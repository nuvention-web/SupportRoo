module ApplicationHelper
  
  def flash_helper name
    n = name.to_s
    if n == 'notice' 
      'success' 
    elsif n == 'warning'
      'warning'
    else
      'alert' 
    end
  end

end
