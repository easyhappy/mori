module BookHelper
  def second_level_nav book
    contents_tag :ol, :class => :breadcrumb do |contents|
      contents << content_tag(:li, "首页/")
      contents << link_to(book.category.name + "/", book.category)
      contents << link_to(book.name  + "/", book)
      contents << content_tag(:li, "章节列表", :class => "active")
    end
  end
end