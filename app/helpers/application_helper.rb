module ApplicationHelper
  def flash_message
    if flash[:notice]
      content_tag(:div, flash[:notice], class: "alert alert-success")
    elsif flash[:alert]
      content_tag(:div, flash[:notice], class: "alert alert-danger")
    end
  end
end
