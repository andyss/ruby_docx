module RubyDocx::Elements
  class Element

    attr_reader :node

    def initialize(node)
      @node = node
    end

    def to_s
      @node.to_s
    end

    def inspect
      "#<#{self.class} @node=#{@node.name}>"
    end
  end
end
