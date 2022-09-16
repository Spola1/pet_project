module ApplicationHelper
  def nav_tab(title, url, options = {})
    current_page = options.delete :current_page

    if current_page == title
      css_class = 'text-white btn btn-secondary m-1'
    else
       css_class = 'text-white btn btn-dark m-1'
    end

    options[:class] = if options[:class]
                        options[:class] + ' ' + css_class
                      else
                        css_class
                      end

    link_to title, url, options
  end

  def currently_at(current_page = '')
    render partial: 'shared/menu', locals: {current_page: current_page}
  end

  def full_title(page_title = "")
    base_title = "AskIt"
    if page_title.present?
      "#{page_title} | #{base_title}"
    else
      base_title
    end
  end
end
