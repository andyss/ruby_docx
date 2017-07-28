require 'texmath'
require 'calculus'
require 'mathtype'
require 'mathtype_to_mathml'

module Mathtype
  class Converter
    def initialize(equation)
      ole = Ole::Storage.open(equation)
      eq = ole.file.read("Equation Native")[28..-1]

      data = Mathtype::Equation.read(eq).snapshot
      @builder = Nokogiri::XML::Builder.new do |xml|
        @xml = xml
        xml.root do
          process(object: data)
        end
      end
    end

  end
end

module RubyDocx::Elements
  class OleObject < Element
    attr_accessor :path, :zip, :link
    attr_accessor :image_path

    # def style
    #   element = @node.xpath(".//v:shape").first
    #   if element && element.attributes.keys.index("style")
    #     element.attributes["style"].value
    #   else
    #     nil
    #   end
    # end

    def relation_id
      element = @node.xpath(".//o:OLEObject").first
      if element && element.attributes.keys.index("id")
        element.attributes["id"].value
      else
        nil
      end
    end

    def to_mathml
      io = StringIO.new(@zip.read("word/" + @path))
      # xml = Mathtype::Converter.new(io)
      # # puts xml.to_xml
      # xml.to_xml

      mathml = MathTypeToMathML::Converter.new(io).convert
    end

    def to_latex
      TeXMath.convert("#{self.to_mathml}", :from => :mathml, :to => :tex)
    end

    def to_png
      @image_path ||= Calculus::Expression.new("#{self.to_latex}", :parse => false).to_png
      File.read(@image_path)
    end

    def data
      self.to_png
    end

    def base64_data
      "data:image/png;base64,#{Base64.strict_encode64(self.to_png)}"
    end

    def size
      return @size if @size

      sz = ImageSize.new(self.data)

      @size = [sz.width/7.2, sz.height/7.2]
    rescue
      nil
    end

    def style
      if self.size
        "width: #{self.size[0]}px; height: #{self.size[0]}px;"
      else
        nil
      end
    end

    def save(path)
      file = File.new(path, "wb")
      file.write(self.to_png)
      file.close
    end

    def replace(lnk)
      @link = lnk
    end

    def to_html
      if self.style
        if @link
          "<img class=\"Wirisformula\" role='math' src='#{@link}' data-latex=\"#{self.to_latex}\" data-mathml=\"#{self.to_mathml.gsub("\n", "").gsub("<", "«").gsub(">", "»").gsub("\"", "¨")}\" style='#{self.style}' />"
        else
          "<img class=\"Wirisformula\" role='math' src='#{self.base64_data}' data-latex=\"#{self.to_latex}\" data-mathml=\"#{self.to_mathml.gsub("\n", "").gsub("<", "«").gsub(">", "»").gsub("\"", "¨")}\" style='#{self.style}' />"
        end

      else
        if @link
          "<img class=\"Wirisformula\" role='math' src='#{@link}' data-latex=\"#{self.to_latex}\" data-mathml=\"#{self.to_mathml.gsub("\n", "").gsub("<", "«").gsub(">", "»").gsub("\"", "¨")}\" style='height: 13px;' />"
        else
          "<img class=\"Wirisformula\" role='math' src='#{self.base64_data}' data-latex=\"#{self.to_latex}\" data-mathml=\"#{self.to_mathml.gsub("\n", "").gsub("<", "«").gsub(">", "»").gsub("\"", "¨")}\" style='height: 13px;' />"
        end
      end

    end

    def to_s
      self.to_latex.to_s
    end

  end
end
