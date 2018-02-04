# *************************************
#  Custom Helpers
# *************************************

module CustomHelpers
  # Components
  # ==================================
  def component(path, locals={})
    partial "components/#{path}", locals
  end
  # Material Icon
  # ==================================
  def icon(*names)
    content_tag(:i, nil, class: icon_classes(names))
  end
  # material_icon
  # ==================================
  def material_icon(name)
    content_tag(:i, name.to_s, class: 'material-icons')
  end
  
  private
  
  def icon_classes(*names)
    names[0].map{|name| "icon-#{name}"}
  end
  # Font-Awesome
  # ==================================
  def fa(name)
    return "<i class='fa fa-#{name}' aria-hidden='true'></i>"
  end
  # Breadcrumbs
  # ==================================
  def get_breadcrumbs(home = 'Home')
    current_page_data = current_page
    hierarchy = [current_page_data]
    hierarchy.unshift hierarchy.first.parent while hierarchy.first.parent
    breadcrumbs = current_page_data.metadata[:page]['breadcrumbs']
    list = []
    hierarchy.each_with_index do |page, index|
      title =
      if breadcrumbs.blank?
        page.data.title
      else
        breadcrumbs[index - 1]
      end
      list <<
      case index
      when 0
        content_tag(:li, link_to(home, '/'), class: 'breadcrumb')
      when hierarchy.size - 1
        content_tag(:li, title, class: 'breadcrumb active')
      else
        content_tag(:li, link_to(title, '/'), class: 'breadcrumb')
      end
    end
    list.join.html_safe
  end
end
