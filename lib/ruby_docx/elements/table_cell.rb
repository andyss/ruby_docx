module RubyDocx::Elements
  class TableCell < Element

    def to_s
      self.elements.map(&:to_s).join
    end

    def inner_html
      "#{self.elements.map(&:to_html).join}"
    end

    def to_html
      w = 0
      if self.style
        w = self.style.width.to_i
      end

      if w > 0
        "<td style='width: #{(w/100.0).round(2)}%'>#{self.elements.map(&:to_html).join}</td>"
      else
        "<td>#{self.elements.map(&:to_html).join}</td>"
      end
    end

  end
end
