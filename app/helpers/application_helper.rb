module ApplicationHelper

 def get_gmail_attribute(data, attribute)
 
  hea = data.payload.headers

  array = hea.reject { |hash| hash.name != attribute }

  array.first.value

end

  def flash_class(level)
    case level
    when :notice then "alert alert-success"
    when :success then "alert alert-success"
    when :error then "alert alert-danger"
    when :alert then "alert alert-danger"
    end
  end

end
