module Refinery
  module Executives
    class ExecutivesController < ::ApplicationController

      before_action :find_all_executives
      before_action :find_page

      def index
        # you can use meta fields from your model instead (e.g. browser_title)
        # by swapping @page for @executive in the line below:
        present(@page)
      end

      def show
        @executive = Executive.find(params[:id])

        # you can use meta fields from your model instead (e.g. browser_title)
        # by swapping @page for @executive in the line below:
        present(@page)
      end

    protected

      def find_all_executives
        @executives = Executive.order('position ASC')
      end

      def find_page
        @page = ::Refinery::Page.where(:link_url => "/executives").first
      end

    end
  end
end
