require 'nokogiri'
require 'zip'

require "ruby_docx/elements"
require "ruby_docx/relation"

module RubyDocx

  class Html
    # attr_reader :xml, :doc, :zip, :styles, :styles_xml, :rels
    attr_reader :doc, :html_str, :zip, :xml_doc, :xml

    def self.open_path(path)
      self.new(File.read(path))
    end

    def self.parse(html_str)
      self.new(html_str)
    end

    def initialize(html_str)
      @html_str = html_str
      @doc = Nokogiri::HTML(@html_str)

      @zip = Zip::File.open("template.docx")

      @xml = @zip.read('word/document.xml')
      @xml_doc = Nokogiri::XML(@xml)

      # @path = path
      # @zip = Zip::File.open(path)

      # rels_xml = @zip.read('word/_rels/document.xml.rels')
      # @rels = Nokogiri::XML(rels_xml)
      # @rels.remove_namespaces!
      # @doc = Nokogiri::XML(@xml)
      # @styles_xml = @zip.read('word/styles.xml')
      # @styles = Nokogiri::XML(@styles_xml)
    end

    def save(path)
      Zip::OutputStream.open(path) do |out|
        @zip.each do |entry|
          out.put_next_entry(entry.name)

          unless entry.name  =~ /\/$/
            out.write(@zip.read(entry.name))
          end
        end
      end
    end

  end

end
