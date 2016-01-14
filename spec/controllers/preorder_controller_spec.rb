require 'spec_helper'

describe PreorderController do
  fixtures :projects

  [:index, :checkout].each do |method|
    it "should get #{method}" do
      get method
      response.should be_success
    end
  end
end