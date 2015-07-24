class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def format_money(amount)
    decimal_part = ((amount * 100) % 100).to_i
    integer_part = amount.to_i
    if decimal_part < 10
      "$#{integer_part}.0#{decimal_part}"
    else
      "$#{integer_part}.#{decimal_part}"
    end
  end

  helper_method :format_money
end
