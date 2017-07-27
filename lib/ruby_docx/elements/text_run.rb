module RubyDocx::Elements
  class TextRun < Element
    attr_reader :font_name, :font_size, :color
    attr_accessor :content

    def underline?
      @node.xpath(".//w:u").size > 0
    end

    def to_s
      if underline?
        self.elements.map do |ele|
          if ele.class == RubyDocx::Elements::Text
            ele.to_s.gsub(/ /, "_")
          else
            ele.to_s
          end
        end.join(" ")

      else
        self.elements.map(&:to_s).join(" ")
      end
    end

    def to_html
      if underline?
        s = "<span>"

        self.elements.map do |ele|
          if ele.class == RubyDocx::Elements::Text
            s += ele.to_s.gsub(/ /, "_")
          else
            s += ele.to_html
          end
        end

        s += "</span>"

        s
      else
        "<span>#{self.elements.map(&:to_html).join}</span>"
      end
    end

  end
end
