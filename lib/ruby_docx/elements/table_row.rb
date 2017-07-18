module RubyDocx::Elements
  class TableRow < Element

    def cells
      self.elements
    end

    def to_s
      s = ""

      self.cells.map do |cell|
        s += "#{cell.to_s}\t"
      end

      s += "\n"

      s
    end

    def to_html
      w = 0
      if self.style
        w = self.style.width.to_i
      end

      s = "<tr>"
      self.cells.map do |cell|
        if w.to_i > 0
          s += "<td style='width: #{(w/100.0).round(2)}%'>#{cell.inner_html}</td>"
        else
          s += "<td>#{cell.inner_html}</td>"
        end
      end

      s += "</tr>"

      s
    end

  end
end
