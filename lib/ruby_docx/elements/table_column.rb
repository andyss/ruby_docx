module RubyDocx::Elements
  class TableColumn < Element

    def col_num
      self.node.children.size
    end

    def widths
      a = []
      self.node.xpath(".//w:gridCol").map do |elem|
        w = elem.attributes["w"].value.to_i

        a << w
      end

      a
    end

    def width_of(num)
      self.widths[num].to_i
    end

  end
end
