module BookHelper
  def second_level_nav book, chapter=nil
    contents_tag :ol, :class => :breadcrumb do |contents|
      contents << content_tag(:li, "首页/")
      contents << link_to(book.category.name + "/", book.category)
      contents << link_to(book.name  + "/", book)
      contents << content_tag(:li, chapter.present? ? chapter.name : "章节列表", :class => "active")
    end
  end

  def chapter_navgation current
    contents_tag :div, :class => "text-center" do |contents|
      if (pre=current.pre).present?
        contents << link_to("上一章：#{truncate pre.name,length: 25} | ", chapter_path(pre))
      else
        contents << link_to("上一章：无 | ")  
      end
      contents << link_to("返回目录 | ", book_path(current.book)) if current.present?
      if (nxt=current.next).present?
        contents << link_to("下一章：#{truncate nxt.name,length: 25}", chapter_path(nxt))
      else
        contents << link_to("下一章：无")  
      end
    end
  end
end