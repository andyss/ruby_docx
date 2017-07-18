module RubyDocx::Elements
  class Paragraph < Element

    def to_s
      "#{self.elements.map(&:to_s).join}"
    end

    def to_html
      if self.elements.size <= 0
        "<p>&nbsp;</p>"
      else
        "<p>#{self.elements.map(&:to_html).join}</p>"
      end

    end
  end
end
