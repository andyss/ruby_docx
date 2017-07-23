require 'nokogiri'
require 'zip'

require "ruby_docx/elements"
require "ruby_docx/relation"

module RubyDocx

  class Document
    attr_reader :xml, :doc, :zip, :styles, :styles_xml, :rels

    def self.open(path)
      self.new(path)
    end

    def initialize(path)
      @path = path
      @zip = Zip::File.open(path)
      @xml = @zip.read('word/document.xml')
      rels_xml = @zip.read('word/_rels/document.xml.rels')
      @rels = Nokogiri::XML(rels_xml)
      @rels.remove_namespaces!
      @doc = Nokogiri::XML(@xml)
      @styles_xml = @zip.read('word/styles.xml')
      @styles = Nokogiri::XML(@styles_xml)
    end

    def paragraphs
      @paragraphs ||= @doc.xpath('//w:document/w:body/w:p|//w:document/w:body/w:tbl').map { |node|
        if node.name.to_s == "tbl"
          RubyDocx::Elements::Table.new self, node
        else
          RubyDocx::Elements::Paragraph.new self, node
        end

      }
    end

    def to_html
      self.paragraphs.map(&:to_html).join
    end

    def setup_drawing(drawing)
      drawing.zip = @zip

      if drawing.node.name.to_s == "drawing"
        element = drawing.node.xpath(".//a:blip", 'a' => "http://schemas.openxmlformats.org/drawingml/2006/picture").first
        # p element, element.attributes["name"].value
        # drawing.path = "media/#{element.attributes["name"].value}"

        relation = self.find_relation_by_id(drawing.relation_id)
        # p relation
        drawing.path = relation.value if relation
        # p drawing.path

      end

      drawing
    end

    def setup_image(img)
      img.zip = @zip

      relation = self.find_relation_by_id(img.relation_id)
      img.path = relation.value if relation

      img
    end

    def setup_object(obj)
      obj.zip = @zip

      relation = self.find_relation_by_id(obj.relation_id)
      obj.path = relation.value if relation

      obj
    end

    def images
      @doc.xpath('//w:pict').map do |node|
        RubyDocx::Elements::Image.new self, node
      end
    end

    def relations
      @rels.xpath("//Relationship").map do |node|
        RubyDocx::Relation.new node
      end
    end

    def find_relation_by_id(relation_id)
      return nil unless relation_id

      self.relations.map do |relation|
        if relation.relation_id.to_s == relation_id
          return relation
        end
      end

      nil
    end

    def inspect
      "#<#{self.class}:0x#{(doc.object_id * 2).to_s(16).rjust(14, "0")} @doc=#{@path}>"
    end

  end

end
