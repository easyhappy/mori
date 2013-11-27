module LayoutHelper
  def current_page_title title
    content_tag :title do
      "#{title || "首页"} - Mori Reading"
    end
  end

  def website_logo
    link_to 'Mori Reading', root_path, :class => "navbar-brand"
  end

  def current_page_header category_id
    contents_tag :ul, :class => "nav navbar-nav" do |contents|
      Category.all.each do |c|
        klass = (category_id.to_i == c.id ? 'active' : '')
        contents << content_tag(:li, link_to(c.name, category_path(c)), :class => klass)
      end
      contents << content_tag(:li, link_to('退出',destroy_user_session_path)) if current_user
    end
  end
end