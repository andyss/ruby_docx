module RubyDocx::Elements
  class TableStyle < Element
    # attr_reader :font_name, :font_size, :color, :text_align, :fonts

    def to_s
      arry = []
      if font_size
        arry << "font-size: #{font_size}pt"
      end

      if fonts
        arry << "font-family: #{fonts.join(",")}"
      end

      if color
        arry << "color: #{color}"
      end

      arry.join(";")
    end

    def align
      ele = @node.xpath(".//w:jc").last

      if ele
        v = ele.attributes["val"].value.to_s
        if v == "start"
          "left"
        elsif v == "end"
          "right"
        elsif v == "center"
          "center"
        end
      else
        nil
      end
    end

    def bold?
      false
    end

    def font_size
      ele = @node.xpath(".//w:sz").last

      if ele
        v = ele.attributes["val"].value
        v.to_i/2
      else
        nil
      end

    end

    def color
      ele = @node.xpath(".//w:color").last

      if ele
        v = ele.attributes["val"].value
        if v.to_s == "auto"
          nil
        else
          v
        end
      else
        nil
      end
    end

    def font_name
      ele = @node.xpath(".//w:rFonts").last

      if ele
        ascii = ele.attributes["ascii"]
        cs = ele.attributes["cs"]
        hAnsi = ele.attributes["hAnsi"]

        ascii.value
      else
        nil
      end
    end


    def fonts
      ele = @node.xpath(".//w:rFonts").last

      if ele
        ascii = ele.attributes["ascii"]
        cs = ele.attributes["cs"]
        hAnsi = ele.attributes["hAnsi"]

        [ascii.value, cs.value, hAnsi.value].uniq
      else
        nil
      end
    end


  end
end
