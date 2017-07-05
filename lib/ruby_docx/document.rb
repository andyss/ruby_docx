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
      @doc.xpath('//w:document//w:body//w:p').map { |node|
        RubyDocx::Elements::Paragraph.new self, node
      }
    end

    def setup_image(img)
      img.zip = @zip

      relation = self.find_relation_by_id(img.relation_id)

      img.path = relation.value if relation

      img
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
