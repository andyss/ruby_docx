module RubyDocx::Elements
  class Table < Element

    def to_s
      s = "\n"
      self.trs.map do |tr|
        tr.cells.map do |cell|
          s += "#{cell.to_s}\t"
        end

        s += "\n"
      end

      s += "\n"

      s
    end

    def to_html
      s = "<table>"

      self.trs.each_with_index do |tr, i|
        if self.grid
          w = self.grid.width_of(i).to_i
        end

        s += "<tr>"

        tr.cells.map do |cell|
          if w.to_i > 0
            s += "<td style='width: #{(w/100.0).round(2)}%'>#{cell.to_html}</td>"
          else
            s += "<td>#{cell.to_html}</td>"
          end
        end

        s += "</tr>"
      end

      s += "</table>"

      s
    end


    def trs
      self.elements
    end

  end
end
