module ShowBuilderExtensionHelper
end

module Showbuilder
  module Builders
    class ShowModelTableRowBuilder
      def show_buttons_column(*methods)
        return show_header_column(methods) if is_header
        name = get_methods_text_value(model, methods)
        contents_tag :td, :class => 'text' do |contents|
          contents << link_to("继续阅读",model.current_chapter)
          contents << link_to("下一章",chapter_path(model.current_chapter,m: 'next'))
          contents << link_to("上一章",chapter_path(model.current_chapter,m: 'pre'))
          contents << link_to("目录",  book_path(model.book))
        end
      end
    end
  end
end