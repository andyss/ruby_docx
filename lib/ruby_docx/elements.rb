require "ruby_docx/elements/element"
require "ruby_docx/elements/equation"
require "ruby_docx/elements/image"
require "ruby_docx/elements/drawing"
require "ruby_docx/elements/ole_object"
require "ruby_docx/elements/style"
require "ruby_docx/elements/table_style"
require "ruby_docx/elements/table_row"
require "ruby_docx/elements/table_column"
require "ruby_docx/elements/table_cell"
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
      "rPr" => RubyDocx::Elements::Style,
      "tblPr" => RubyDocx::Elements::TableStyle,
      "tcPr" => RubyDocx::Elements::TableStyle,
      "pict" => RubyDocx::Elements::Image,
      "drawing" => RubyDocx::Elements::Drawing,
      "p" => RubyDocx::Elements::Paragraph,
      "r" => RubyDocx::Elements::TextRun,
      "t" => RubyDocx::Elements::Text,
      "hyperlink" => RubyDocx::Elements::Link,
      "bookmarkStart" => RubyDocx::Elements::Bookmark,
      "tbl" => RubyDocx::Elements::Table,
      "tr" => RubyDocx::Elements::TableRow,
      "tc" => RubyDocx::Elements::TableCell,
      "tblGrid" => RubyDocx::Elements::TableColumn,
      "object" => RubyDocx::Elements::OleObject,
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
