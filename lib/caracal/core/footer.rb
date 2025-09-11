require 'caracal/core/models/footer_model'
require 'caracal/errors'


module Caracal
  module Core

    # This module encapsulates all the functionality related to adding a
    # footer on every page of the document.
    #
    module Footer
      def self.included(base)
        base.class_eval do

          #-------------------------------------------------------------
          # Public Methods
          #-------------------------------------------------------------

          def footer(*args, &block)
            options = Caracal::Utilities.extract_options!(args)

            model = Caracal::Core::Models::FooterModel.new(options, &block)

            if model.first_page_only
              @first_page_footer_content = model
            else
              @footer_content = model
            end

            model
          end

        end
      end
    end
  end
end
