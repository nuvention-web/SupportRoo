module ApplicationHelper
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i

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
