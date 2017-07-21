module RubyDocx::Htmls
  class HtmlText

    def to_xml
      "<w:r>#{self.elements.map(&:to_xml).join}</w:r>"
    end

  end
end
