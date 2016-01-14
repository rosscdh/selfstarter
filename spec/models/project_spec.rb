require 'spec_helper'

describe Project do
  context "New Base Project" do
    fixtures :projects, :orders

    before do
      @project = Project.find_by(slug: "example-project-for-investment")
    end

    describe "instance methods!" do

      it ".url" do
        @project.url == "/projects/example-project-for-investment"
      end
      it ".percent" do
        @project.percent == 0.00
      end
      it ".num_backers" do
        @project.num_backers == 0
      end
      it ".revenue" do
        @project.revenue == 02
      end

    end # End Describe

  end # End Context
end
