module LayoutHelper
  def current_page_title title
    content_tag :title do
      "#{title || "首页"} - Mori Reading"
    end
  end

  def website_logo
    link_to 'Mori Reading', root_path, :class => "navbar-brand"
  end

  def current_page_header params, category_id=nil
    contents_tag :div, :class => 'navbar-collapse collapse' do |cs|
      cs << current_page_header_nav_part(category_id)
      cs << current_page_header_search_part(params)
      cs << current_page_header_user_part
    end
  end

  private

  def current_page_header_user_part
    contents_tag :ul, :class => "nav navbar-nav pull-right", :id => "userbar" do |contents|
      if user_signed_in?
        contents << content_tag(:li, link_to('退出', destroy_user_session_path, :class => :navfont))
      else
        contents << content_tag(:li, link_to('注册', new_user_registration_path, :class => :navfont))
        contents << content_tag(:li, link_to('登陆', new_user_session_path, :class => :navfont))
      end
    end
  end

  def current_page_header_nav_part(category_id)
    contents_tag(:ul, :class => "nav navbar-nav") do |contents|
      categories = Category.all
      show_count = 5
      categories[0..(show_count-1)].each do |c|
        klass = (category_id.to_i == c.id ? 'active navbar-li' : 'navbar-li')
        contents << content_tag(:li, link_to(c.name, category_path(c), :class => 'navfont'), :class => klass)
      end

      contents << current_page_header_nav_more_part(categories[(show_count+1)..-1])
    end
  end

  def current_page_header_nav_more_part categories
    return unless categories.present?
    contents_tag(:li, :class => 'dropdown') do |cs|
      cs << content_tag(:a, :class => 'dropdown-toggle', 'data-toggle' => "dropdown") do
        "更多<b class='caret'></b>".html_safe
      end
      
      cs << contents_tag(:ul, :class => 'dropdown-menu') do |cs2|
        categories.each do |c|
        klass = 'navbar-li'
        cs2 << content_tag(:li, link_to(c.name, category_path(c), :class => 'navfont'), :class => klass)
        end
      end
    end
  end

  def current_page_header_search_part params
    contents_tag :form, :action => '/books/search', :class => 'navbar-form navbar-left', :role => 'search' do |cs|
      cs << content_tag(:div, :class => "form-group") do
        content_tag(:input, nil, :name => :q, :class => "form-control",  :placeholder => "搜索", :type => 'text', :value => params[:q])
      end
    end
  end
end