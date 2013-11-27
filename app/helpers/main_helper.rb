module MainHelper
  def history_books_sidebar history_books, itext
    contents_tag :ol, :class => "nav nav-list" do |contents|
      contents << content_tag(:li, itext, :class => "nav-header")
      history_books.each do |hb|
        contents << content_tag(:li, :style => "margin-left:5px;") do
          "[#{link_to hb.category.name,hb.category}] #{link_to hb.name,hb}".html_safe
        end
      end
    end
  end
end