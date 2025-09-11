require 'caracal/core/models/base_model'
require 'caracal/core/models/margin_model'
require 'caracal/core/models/paragraph_model'


module Caracal
  module Core
    module Models

      attr_reader :first_page_only
      
      # This class handles block options passed to tables via their data
      # collections.
      #
      class FooterModel < BaseModel

        #-------------------------------------------------------------
        # Configuration
        #-------------------------------------------------------------

        # initialization
        def initialize(options={}, &block)
          @first_page_only = options[:first_page_only] || false
          
          super options, &block
        end

        #-------------------------------------------------------------
        # Public Methods
        #-------------------------------------------------------------

        #=============== DATA ACCESSORS =======================

        def contents
          @contents ||= []
        end

        def first_page_only
          @first_page_only
        end

        #=============== VALIDATION ===========================

        def valid?
          contents.size > 0
        end
      end
    end
  end
end
