module RubyDocx::Htmls
  class HtmlParagraph

    def to_xml
      "<w:p>#{self.elements.map(&:to_xml).join}</w:p>"
    end

  end
end
