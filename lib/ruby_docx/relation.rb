module RubyDocx

  class Relation

    def initialize(node)
      @node = node
    end

    def relation_id
      @node.attributes["Id"].value
    end

    def value
      @node.attributes["Target"].value
    end

  end
end
