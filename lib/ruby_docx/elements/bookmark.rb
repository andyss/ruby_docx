module RubyDocx::Elements
  class Bookmark < Element
    attr_reader :anchor

    def element
      @element ||= @node.children.first
    end

    def anchor
      return @anchor if @anchor
      return "" if @node.attributes["name"].to_s.size <= 0

      name = @node.attributes["name"].value.to_s

      if name == "_GoBack"
        nil
      else
        @anchor = name
      end
    end

    def anchor=(an)
      @anchor = an
    end

    def replace(an)
      self.anchor = an
    end

    def to_html
      if self.anchor
        "<span name=\"#{self.anchor}\"></span>"
      else
        ""
      end
    end

    def to_s
      ""
    end
  end
end
