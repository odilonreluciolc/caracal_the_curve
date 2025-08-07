require 'caracal/core/models/base_model'


module Caracal
  module Core
    module Models
      
      # This class encapsulates the logic needed to store and manipulate
      # font data.
      #
      class FontModel < BaseModel
        
        #-------------------------------------------------------------
        # Configuration
        #-------------------------------------------------------------

        # constants
        const_set(:DEFAULT_BOLD,   false)
        const_set(:DEFAULT_ITALIC, false)
        
        # accessors
        attr_reader :font_name
        attr_reader :font_path
        attr_reader :font_bold
        attr_reader :font_italic
        attr_reader :font_key
        
        # initialization
        def initialize(options={}, &block)
          @font_name   = options[:name]
          @font_path   = options[:path]
          @font_key    = options[:key]
          @font_bold   = DEFAULT_BOLD
          @font_italic = DEFAULT_ITALIC
          
          super options, &block
        end
        
        #-------------------------------------------------------------
        # Public Instance Methods
        #-------------------------------------------------------------
    
        #=============== SETTERS ==============================
        
        # strings
        [:name, :key, :path].each do |m|
          define_method "#{ m }" do |value|
            instance_variable_set("@font_#{ m }", value.to_s)
          end
        end

        # booleans
        [:bold, :italic].each do |m|
          define_method "#{ m }" do |value|
            instance_variable_set("@font_#{ m }", !!value)
          end
        end
        
        
        #=============== STATE ================================
        
        def matches?(str)
          font_name.to_s.downcase == str.to_s.downcase
        end
        
        
        #=============== VALIDATION ===========================
        
        def valid?
          a = [:name]
          a.map { |m| send("font_#{ m }") }.compact.size == a.size
        end
        
        def embed?
          !!@font_path
        end

        def relationship_id
          "rIdFont_#{@font_name.gsub(/\s+/, '_')}"
        end
        
        #-------------------------------------------------------------
        # Private Instance Methods
        #-------------------------------------------------------------
        private
        
        def option_keys
          [:name, :key, :path, :bold, :italic]
        end
        
      end
      
    end
  end
end