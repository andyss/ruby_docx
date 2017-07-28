require 'texmath'
require 'calculus'

module RubyDocx::Elements
  class Equation < Element

    attr_accessor :link

    def to_omml
      ele = @node.xpath(".//m:oMath").first
      ele.to_s
    end

    def to_latex
       TeXMath.convert("#{self.to_omml}", :from => :omml, :to => :tex)
    end

    def to_mathml
       TeXMath.convert("#{self.to_omml}", :from => :omml, :to => :mathml)
    end


    def replace_with_mathml(txt)
    end

    def replace_with_latex(txt)
    end

    def to_png
      @path ||= Calculus::Expression.new("#{self.to_latex}", :parse => false).to_png
      File.read(@path)
    end

    def data
      self.to_png
    end

    def base64_data
      "data:image/png;base64,#{Base64.strict_encode64(self.to_png)}"
    end

    def save(path)
      file = File.new(path, "wb")
      file.write(self.to_png)
      file.close
    end

    def replace(lnk)
      @link = lnk
    end

    def to_html
      if @link
        "<img src='#{@link}' data-latex=\"#{self.to_latex}\" data-mathml=\"#{self.to_mathml}\" style='height: 13px;' />"
      else
        "<img src='#{self.base64_data}' data-latex=\"#{self.to_latex}\" data-mathml=\"#{self.to_mathml}\" style='height: 13px;' />"
      end
    end

    def to_s
      self.to_latex.to_s
    end

  end
end
