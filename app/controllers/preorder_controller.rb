class PreorderController < ApplicationController
  skip_before_action :verify_authenticity_token, :only => :ipn
  before_action :get_project

  def index
  end

  def checkout
    @order = Order.new(:project_id => @project.id)
    @submit_url = url_for(action: 'prefill', controller: 'preorder', only_path: true, slug: @project.slug)
  end

  def prefill
    @user = User.find_or_create_by(:email => params[:email])

    if Settings.use_payment_options
      payment_option_id = params['payment_option']
      raise Exception.new("No payment option was selected") if payment_option_id.nil?
      payment_option = PaymentOption.find(payment_option_id)
      price = payment_option.amount.to_f
    else
      price = params[:price].to_f
    end

    @order = Order.prefill!(:name => @project.name,
                            :project_id => @project.id,
                            :price => price,
                            :user_id => @user.id,
                            :payment_option => payment_option)

    # This is where all the magic happens. We create a multi-use token with Amazon, letting us charge the user's Amazon account
    # Then, if they confirm the payment, Amazon POSTs us their shipping details and phone number
    # From there, we save it, and voila, we got ourselves a preorder!
    port = Rails.env.production? ? "" : ":3000"
    # @TODO better way to do this using url_for with delegate
    #callback_url = "#{request.scheme}://#{request.host}#{port}/p/#{@project.id}/preorder/postfill"
    callback_url = url_for(action: 'postfill', controller: 'preorder', only_path: false, slug: @project.slug)
    redirect_to AmazonFlexPay.multi_use_pipeline(@order.uuid, callback_url,
                                                 :transaction_amount => price,
                                                 :global_amount_limit => price + Settings.charge_limit,
                                                 :collect_shipping_address => "True",
                                                 :payment_reason => @project.payment_description)
  end

  def postfill
    # @TODO ensure that we get the right Order object here
    unless params[:callerReference].blank?
      @order = Order.postfill!(params)
    end
    # "A" means the user cancelled the preorder before clicking "Confirm" on Amazon Payments.
    if params['status'] != 'A' && @order.present?
      redirect_to :action => :share, :uuid => @order.uuid
    else
      redirect_to root_url
    end
  end

  def share
    @order = Order.find_by(:uuid => params[:uuid])
  end

  def ipn
  end

  protected

    def get_project
      @project = Project.find params[:slug]
    end

end
