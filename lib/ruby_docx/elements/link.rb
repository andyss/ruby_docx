module RubyDocx::Elements
  class Link < Element
    attr_reader :href, :content, :html_content

    def element
      @element ||= @node.children.first
    end

    def href
      @href ||= @node.attributes["anchor"].value.to_s
    end

    def href=(an)
      @href = an
    end

    def content
      @content ||= self.elements.map(&:to_s).join("")
    end

    def content=(txt)
      @content = txt
    end

    def html_content
      @html_content ||= self.elements.map(&:to_html).join("")
    end

    def html_content=(html)
      @html_content = html
    end

    def replace(url)
      self.href = url
    end

    def to_html
      if !self.href
        "#{self.html_content}"
      elsif self.href.to_s =~ /^http/
        "<a href=\"#{self.href}\">#{self.html_content}</a>"
      else
        "<a href=\"##{self.href}\">#{self.html_content}</a>"
      end
    end

    def to_s
      self.content.to_s
    end
  end
end
