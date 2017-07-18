require 'texmath'
require 'calculus'

module RubyDocx::Elements
  class OleObject < Element

    def to_html
      "<img src='#{self.base64_data}' data-latex=\"#{self.to_latex}\" style='width: 30px;' />"
    end

    def to_s
      self.to_latex.to_s
    end

  end
end
