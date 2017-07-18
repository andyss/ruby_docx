
module RubyDocx::Elements
  class Element

    attr_reader :node, :doc, :style, :grid


    def initialize(doc, node)
      @node = node
      @doc = doc

      if self.node.name.to_s == "pict"
        @doc.setup_image(self)
      elsif self.node.name.to_s == "drawing"
        @doc.setup_drawing(self)
      end

      self.parse_elements
    end

    def to_s
      @node.to_s
    end

    def to_xml
      @node.to_s
    end

    def elements
      @elements ||= @node.children.map do |c_node|
        v = RubyDocx::Elements::Parser.parse_by_name(@doc, c_node)

        if ["pPr", "rPr", "tblPr", "tcPr"].index(c_node.name.to_s)
          @style = v
          nil
        elsif ["tblGrid"].index(c_node.name.to_s)
          @grid = v
          nil
        else
          v
        end
      end.compact
    end

    alias :parse_elements :elements

    def inspect
      "#<#{self.class} @node=#{@node.name}>"
    end
  end
end
