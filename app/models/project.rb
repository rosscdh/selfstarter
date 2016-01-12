class Project < ActiveRecord::Base
  extend FriendlyId

  delegate :url_helpers, :to => 'Rails.application.routes'

  has_many :orders
  has_many :payment_options
  has_many :documents

  mount_uploader :image, ProjectImageUploader

  friendly_id :slug, use: [:slugged, :finders]

  def url
    url_helpers.url_for(action: 'detail', controller: 'project', only_path: true, slug: self.slug)
  end

  def percent
    (revenue.to_f / project_goal.to_f) * 100.to_f
  end

  def num_backers
    orders.completed.count
  end

  def revenue
    if Settings.use_payment_options
      PaymentOption.joins(:orders).where("token != ? OR token != ?", "", nil).pluck('sum(amount)')[0].to_f
    else
      orders.to_a.sum(&:price)
    end
  end

end
