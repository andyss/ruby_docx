require 'nokogiri'
require 'zip'

require "ruby_docx/elements/element"
require "ruby_docx/elements/paragraph"
require "ruby_docx/elements/table"

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
      @doc.xpath('//w:document//w:body//w:p').map { |node| RubyDocx::Elements::Paragraph.new node }
    end

    def inspect
      "#<#{self.class}:0x#{(doc.object_id * 2).to_s(16).rjust(14, "0")} @doc=#{@path}>"
    end

  end

end
