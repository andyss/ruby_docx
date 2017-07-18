module RubyDocx::Elements
  class Text < Element
    attr_reader :font_name, :font_size, :color
    attr_accessor :content

    def element
      @element ||= @node.children.first
    end

    def content
      @content ||= self.element.to_s
    end

    def content=(txt)
      @content = txt

      self.element.content = txt

      @content
    end

    def to_s
      self.content.to_s
    end

    def to_html
      "#{self.content.gsub(/ /, "&nbsp;")}"
    end

  end
end
