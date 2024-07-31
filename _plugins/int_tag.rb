# _plugins/hint_tag.rb
module Jekyll
  class HintTag < Liquid::Block
    def initialize(tag_name, markup, tokens)
      super
      @style = markup.strip
    end

    def render(context)
      content = super
      case @style
      when "info"
        style_class = "hint hint-info"
      when "warning"
        style_class = "hint hint-warning"
      when "error"
        style_class = "hint hint-error"
      else
        style_class = "hint"
      end
      "<div class='#{style_class}'>#{content}</div>"
    end
  end
end

Liquid::Template.register_tag('hint', Jekyll::HintTag)