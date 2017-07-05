require 'texmath'
require 'calculus'

module RubyDocx::Elements
  class Equation < Element

    def to_omml
      ele = @node.xpath("//m:oMath").first
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

    def to_svg
    end

    def to_png
    end

    def to_html
    end

    def to_s
      self.to_latex.to_s
    end

  end
end
