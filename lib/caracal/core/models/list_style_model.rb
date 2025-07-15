module Caracal
  module Core
    module Models
      
      # This class encapsulates the logic needed to store and manipulate
      # list style data.
      #
      class ListStyleModel < BaseModel
        
        #-------------------------------------------------------------
        # Configuration
        #-------------------------------------------------------------
        
        # constants
        const_set(:TYPE_MAP,              { ordered: 1, unordered: 2 })
        const_set(:DEFAULT_STYLE_LEFT,    720)      # units in twips 
        const_set(:DEFAULT_STYLE_INDENT,  360)      # units in twips 
        const_set(:DEFAULT_STYLE_ALIGN,   :left)
        const_set(:DEFAULT_STYLE_START,   1)
        const_set(:DEFAULT_STYLE_RESTART, 1)
        
        # accessors
        attr_reader :style_type
        attr_reader :style_level
        attr_reader :style_format
        attr_reader :style_value
        attr_reader :style_start
        attr_reader :style_align
        attr_reader :style_left
        attr_reader :style_indent
        attr_reader :style_restart
        attr_reader :style_name
        
        # initialization
        def initialize(options={}, &block)
          @style_align   = DEFAULT_STYLE_ALIGN
          @style_left    = DEFAULT_STYLE_LEFT
          @style_indent  = DEFAULT_STYLE_INDENT
          @style_start   = DEFAULT_STYLE_START
          @style_restart = DEFAULT_STYLE_RESTART
          @style_name    = options[:name] if options[:name]
          
          super options, &block
        end
        
        
        #-------------------------------------------------------------
        # Public Class Methods
        #-------------------------------------------------------------
        
        def self.formatted_type(type)
          TYPE_MAP.fetch(type.to_s.to_sym)
        end
        
        
        #-------------------------------------------------------------
        # Public Instance Methods
        #-------------------------------------------------------------
    
        #=============== GETTERS ==============================
        
        def formatted_type
          self.class.formatted_type(style_type)
        end
        
        
        #=============== SETTERS ==============================
        
        # integers
        [:level, :left, :indent, :start, :restart].each do |m|
          define_method "#{ m }" do |value|
            instance_variable_set("@style_#{ m }", value.to_i)
          end
        end
        
        # strings
        [:format, :value, :name].each do |m|
          define_method "#{ m }" do |value|
            instance_variable_set("@style_#{ m }", value.to_s)
          end
        end
        
        # symbols
        [:type, :align].each do |m|
          define_method "#{ m }" do |value|
            instance_variable_set("@style_#{ m }", value.to_s.to_sym)
          end
        end
        
        
        #=============== STATE ================================
        
        def matches?(type, identifier)
          if identifier.is_a?(Integer)
            style_type == type.to_s.to_sym && style_level == identifier.to_i
          else
            style_type == type.to_s.to_sym && style_name == identifier.to_s.to_sym
          end
        end
        
        
        #=============== VALIDATION ===========================
        
        def valid?
          a = [:type, :level, :format, :value]
          a.map { |m| send("style_#{ m }") }.compact.size == a.size
        end
        
        
        #-------------------------------------------------------------
        # Private Instance Methods
        #-------------------------------------------------------------
        private
        
        def option_keys
          [:type, :level, :format, :value, :align, :left, :indent, :start, :name]
        end
        
      end
      
    end
  end
end