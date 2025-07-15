require 'spec_helper'

RSpec.describe Caracal::Renderers::DocumentRenderer do
  let(:document) { Caracal::Document.new }
  let(:renderer) { described_class.new(document) }

  let(:image_model) do
    instance_double(Caracal::Core::Models::ImageModel,
      class: Caracal::Core::Models::ImageModel,
      formatted_width: 500,
      formatted_height: 300,
      formatted_top: 0,
      formatted_bottom: 0,
      formatted_left: 0,
      formatted_right: 0,
      image_align: :center,
      image_url: 'images/test.png',
      image_data: 'fake_binary')
  end

  let(:table_cell) do
    instance_double(Caracal::Core::Models::TableCellModel,
      cell_colspan: 1,
      cell_rowspan: nil,
      cell_width: 5000,
      cell_background: 'FFFFFF',
      cell_vertical_align: 'center',
      cell_margin_top: 100,
      cell_margin_bottom: 100,
      cell_margin_left: 100,
      cell_margin_right: 100,
      cell_border_top_size: 0,
      cell_border_bottom_size: 0,
      cell_border_left_size: 0,
      cell_border_right_size: 0,
      contents: [image_model])
  end

  let(:table_model) do
    instance_double(Caracal::Core::Models::TableModel,
      class: Caracal::Core::Models::TableModel,
      table_width: 9000,
      table_align: 'center',
      table_border_top_size: 0,
      table_border_bottom_size: 0,
      table_border_left_size: 0,
      table_border_right_size: 0,
      table_border_horizontal_size: 0,
      table_border_vertical_size: 0,
      table_border_top_color: '000000',
      table_border_top_line: 'single',
      table_border_top_spacing: 0,
      rows: [[table_cell]])
  end

  describe '#render_table' do
    it 'calls render_image_in_table_cell for image content' do
      Nokogiri::XML::Builder.new do |xml|
        xml['w'].root('xmlns:w' => 'http://schemas.openxmlformats.org/wordprocessingml/2006/main') do
          allow(renderer).to receive(:render_method_for_model).with(image_model).and_return('render_image')
          expect(renderer).not_to receive(:render_image)
          expect(renderer).to receive(:render_image_in_table_cell).with(xml, image_model)

          renderer.send(:render_table, xml, table_model)
        end
      end

    end
  end
end
