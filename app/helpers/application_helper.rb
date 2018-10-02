module ApplicationHelper
  
  # Returns the full title for an HTML page
  def full_title(page_title = '')
    base_title = "MISI"
    if page_title.empty?
      base_title
    else
      page_title + " :: " + base_title
    end
  end
  
end
