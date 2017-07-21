require "ruby_docx/htmls/html_equation"
require "ruby_docx/htmls/html_image"
require "ruby_docx/htmls/html_link"
require "ruby_docx/htmls/html_paragraph"
require "ruby_docx/htmls/html_table"

module RubyDocx::Htmls

  class Parser
    ELEMENTS_ALIAS = {
      "p" => RubyDocx::Htmls::HtmlParagraph,
      "span" => RubyDocx::Htmls::HtmlText,
      "div" => RubyDocx::Htmls::HtmlParagraph,
      "br" => RubyDocx::Htmls::HtmlBreakLine,
      "img" => RubyDocx::Htmls::HtmlImage,
      "table" => RubyDocx::Htmls::HtmlTable,
      "th" => RubyDocx::Htmls::HtmlTableHeader,
      "tr" => RubyDocx::Htmls::HtmlTableRow,
      "td" => RubyDocx::Htmls::HtmlTableCell,
      "a" => RubyDocx::Htmls::HtmlLink,
    }

    def self.parse_by_name(doc, c_node)
      if ELEMENTS_ALIAS.keys.index(c_node.name.to_s)
        ELEMENTS_ALIAS[c_node.name.to_s].new(doc, c_node)
      end

    end

  end

end
