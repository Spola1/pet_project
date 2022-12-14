module ApplicationHelper
  include Pagy::Frontend

  def nav_tab(title, url, options = {})
    current_page = options.delete(:current_page)

    css_class = if current_page == title
                  'text-white btn btn-secondary m-1'
                else
                  'text-white btn btn-dark m-1'
                end

    options[:class] = if options[:class]
                        options[:class] + ' ' + css_class
                      else
                        css_class
                      end

    link_to(title, url, options)
  end

  def currently_at(current_page = '')
    render(partial: 'shared/menu', locals: { current_page: current_page })
  end

  def full_title(page_title = '')
    base_title = 'Pet project'
    if page_title.present?
      "#{page_title} | #{base_title}"
    else
      base_title
    end
  end

  def pagination(obj)
    raw(pagy_bootstrap_nav(obj)) if obj.count > 20
  end
end
