require 'caracal/core/models/font_file_model'
require 'caracal/errors'


module Caracal
  module Core
    
    # This module encapsulates all the functionality related to registering
    # font files.
    #
    module FontFiles
      def self.included(base)
        base.class_eval do
          
          
          #-------------------------------------------------------------
          # Public Methods
          #-------------------------------------------------------------
          
          #============== ATTRIBUTES ==========================
          
          def font_file(options={}, &block)
            model = Caracal::Core::Models::FontFileModel.new(options, &block)
            
            if model.valid?
              register_font_file(model)
            else
              raise Caracal::Errors::InvalidModelError, 'font file must specify the :name and :path attributes.'
            end
            model
          end
          
          
          #============== GETTERS =============================
          
          def font_files
            @font_files ||= []
          end
          
          def find_font_file(name)
            font_files.find { |ff| ff.matches?(name) }
          end
          
          
          #============== REGISTRATION ========================
          
          def register_font_file(model)
            unregister_font_file(model.font_name)
            font_files << model
            model
          end
          
          def unregister_font_file(name)
            if f = find_font_file(name)
              font_files.delete(f)
            end
          end
          
        end
      end
    end
    
  end
end