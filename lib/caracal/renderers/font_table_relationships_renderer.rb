require 'nokogiri'

require 'caracal/renderers/xml_renderer'


module Caracal
  module Renderers
    class FontTableRelationshipsRenderer < XmlRenderer
      
      #-------------------------------------------------------------
      # Public Methods
      #-------------------------------------------------------------
      
      # This method produces the xml required for the `word/_rels/fontTable.xml.rels` 
      # sub-document.
      #
      def to_xml
        builder = ::Nokogiri::XML::Builder.with(declaration_xml) do |xml|
          xml.send 'Relationships', root_options do
            embedded_font_relationships = document.relationships.select { |r| r.relationship_type == :font_file }
            embedded_font_relationships.each do |relationship|
              xml.send 'Relationship', rel_options(relationship)
            end
          end
        end
        builder.to_xml(save_options)
      end
      
      
      #-------------------------------------------------------------
      # Private Methods
      #------------------------------------------------------------- 
      private
      
      def rel_options(rel)
        { 'Target' => rel.formatted_target, 'Type' => rel.formatted_type, 'Id' => rel.formatted_id}
      end
      
      def root_options
        {
          'xmlns' => 'http://schemas.openxmlformats.org/package/2006/relationships'
        }
      end
   
    end
  end
end