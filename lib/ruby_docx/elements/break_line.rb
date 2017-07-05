module RubyDocx::Elements
  class BreakLine < Element

    def to_html
      "<br>"
    end

    def to_s
      "\n"
    end

  end
end
