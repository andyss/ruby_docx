module RubyDocx::Elements
  class TextRun < Element
    attr_reader :font_name, :font_size, :color
    attr_accessor :content

    def to_s
      self.elements.map(&:to_s).join(" ")
    end

    def to_html
      "<span>#{self.elements.map(&:to_html).join}</span>"
    end

  end
end
