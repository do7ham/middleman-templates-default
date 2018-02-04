# *************************************
#  Custom Helpers
# *************************************

module CustomHelpers
  # Page Title
  # =============================
  def page_title(separator = '-')
    if current_page.data.title
      "#{ current_page.data.title } #{ separator } #{ data.config.title }"
    else
      data.config.title
    end
  end
end
