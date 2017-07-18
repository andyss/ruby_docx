require 'mimemagic'
require "base64"

module RubyDocx::Elements
  class Image < Element
    attr_accessor :path, :zip, :link
    attr_reader :width, :height

    def data
      if self.path
        @zip.read("word/#{@path}")
      else

      end

    end

    def relation_id
      element = @node.xpath(".//v:imagedata").first
      if element && element.attributes.keys.index("id")
        element.attributes["id"].value
      else
        nil
      end
    end

    def replace(lnk)
      @link = lnk
    end

    def style
      element = @node.xpath(".//v:shape").first

      if element && element.attributes.keys.index("style")
        element.attributes["style"].value
      else
        nil
      end
    end

    def title
      element = @node.xpath(".//v:imagedata").first
      if element && element.attributes.keys.index("title")
        element.attributes["title"].value
      else
        nil
      end
    end

    def mime
      MimeMagic.by_magic(self.data).type
    end

    def base64_data
      "data:#{self.mime};base64,#{Base64.strict_encode64(self.data)}"
    end

    def to_html
      if @link.to_s.size > 0
        "<img src='#{@link}' alt=\"#{self.title}\" style=\"#{self.style}\" />"
      else
        "<img src='#{self.base64_data}' alt=\"#{self.title}\" style=\"#{self.style}\" />"
      end

    end

    def save(path)
      if @zip && @path
        file = File.new(path, "wb")
        file.write(self.data)
        file.close
      end
    end

  end
end
