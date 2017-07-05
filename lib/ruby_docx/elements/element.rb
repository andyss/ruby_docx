
module RubyDocx::Elements
  class Element

    attr_reader :node, :doc, :style

    def initialize(doc, node)
      @node = node
      @doc = doc

      if self.node.name.to_s == "pict"
        @doc.setup_image(self)
      end

      self.elements
    end

    def to_s
      @node.to_s
    end

    def to_xml
      @node.to_s
    end

    def elements
      @elements ||= @node.children.map do |c_node|
        if c_node.name.to_s == "pPr" || c_node.name.to_s == "rPr"
          @style = RubyDocx::Elements::Parser.parse_by_name(@doc, c_node)

          nil
        else
          RubyDocx::Elements::Parser.parse_by_name(@doc, c_node)
        end
      end.compact
    end

    def inspect
      "#<#{self.class} @node=#{@node.name}>"
    end
  end
end
