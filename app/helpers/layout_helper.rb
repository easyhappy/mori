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
    contents_tag :div, :class => 'navbar-collapse collapse' do |cs|
      cs << current_page_header_nav_part
      cs << current_page_header_search_part
      cs << current_page_header_user_part
    end
  end

  private

  def current_page_header_user_part
    
  end

  def current_page_header_nav_part
    contents_tag(:ul, :class => "nav navbar-nav") do |contents|
      Category.limit(5).each do |c|
        klass = (category_id.to_i == c.id ? 'active navbar-li' : 'navbar-li')
        contents << content_tag(:li, link_to(c.name, category_path(c), :class => 'navfont'), :class => klass)
      end
      contents << content_tag(:li, link_to('退出',destroy_user_session_path)) if current_user
    end
  end

  def current_page_header_search_part
    contents_tag :form, :class => 'navbar-form navbar-left', :role => 'search' do |cs|
      cs << content_tag(:div, :class => "form-group") do
        content_tag(:input, nil, :class => "form-control",  :placeholder => "搜索", :type => 'text')
      end
    end
  end
end