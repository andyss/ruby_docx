require "ruby_docx/elements/element"
require "ruby_docx/elements/equation"
require "ruby_docx/elements/image"
require "ruby_docx/elements/style"
require "ruby_docx/elements/table"
require "ruby_docx/elements/text"
require "ruby_docx/elements/text_run"
require "ruby_docx/elements/link"
require "ruby_docx/elements/bookmark"
require "ruby_docx/elements/paragraph"
require "ruby_docx/elements/break_line"

module RubyDocx::Elements

  class Parser
    ELEMENTS_ALIAS = {
      "pPr" => RubyDocx::Elements::Style,
      "pict" => RubyDocx::Elements::Image,
      "r" => RubyDocx::Elements::TextRun,
      "t" => RubyDocx::Elements::Text,
      "hyperlink" => RubyDocx::Elements::Link,
      "bookmarkStart" => RubyDocx::Elements::Bookmark,
      # "bookmarkEnd" => RubyDocx::Elements::Link,
      "br" => RubyDocx::Elements::BreakLine,
      "oMathPara" => RubyDocx::Elements::Equation,
    }

    def self.parse_by_name(doc, c_node)
      if ELEMENTS_ALIAS.keys.index(c_node.name.to_s)
        ELEMENTS_ALIAS[c_node.name.to_s].new(doc, c_node)
      end

    end

  end

end
