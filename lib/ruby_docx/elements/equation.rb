require 'texmath'
require 'calculus'
require "image_size"

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

    def size
      return @size if @size

      sz = ImageSize.new(self.data)

      @size = [sz.width/7.2, sz.height/7.2]
    rescue
      nil
    end

    def style
      if self.size
        "width: #{self.size[0]}px; height: #{self.size[1]}px;"
      else
        ""
      end
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
        "<img class=\"Wirisformula\" role='math' src='#{@link}' data-latex=\"#{self.to_latex}\" data-mathml=\"#{self.to_mathml.gsub("\n", "").gsub("<", "«").gsub(">", "»").gsub("\"", "¨")}\" style='#{self.style}' />"
      else
        "<img class=\"Wirisformula\" role='math' src='#{self.base64_data}' data-latex=\"#{self.to_latex}\" data-mathml=\"#{self.to_mathml.gsub("\n", "").gsub("<", "«").gsub(">", "»").gsub("\"", "¨")}\" style='#{self.style}' />"
      end
    end

    def to_s
      self.to_latex.to_s
    end

  end
end
