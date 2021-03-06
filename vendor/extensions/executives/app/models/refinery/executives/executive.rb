module Refinery
  module Executives
    class Executive < Refinery::Core::BaseModel
      self.table_name = 'refinery_executives'

      attr_accessible :name, :photo_id, :title, :spouse, :website, :webform, :email, :twitter, :facebook, :state_code, :position

      attr_accessor :religion, :family, :birthday

      acts_as_indexed :fields => [:name, :title, :spouse, :website, :webform, :email, :twitter, :facebook, :state_code]

      validates :name, :presence => true, :uniqueness => true

      belongs_to :photo, :class_name => '::Refinery::Image'

      def photo_src
        if photo
          self.photo.url if self.photo
        else
          "placeholder.jpg"
        end
      end

      def district_residence
        ""
      end

      def religion
        ""
      end

      def family
        ""
      end

      def birthday
        ""
      end
    end
  end
end
