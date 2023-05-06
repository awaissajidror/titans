module ResponseAble
  extend ActiveSupport::Concern

  included do
    # code to be executed when the module is included in a class
  end

  class_methods do
    # class-level methods go here
  end

  def success_response
    flash[:success] = set_message
    redirect_to set_url
  end

  def error_response
    flash[:error] = "CashUp Didn't Created Successfully!"
    render params[:action] == 'update' ? :edit : :new
  end

  def set_message
    case params[:controller]
    when 'cash_ups'
      "CashUp #{set_success_text} Successfully!"
    when 'users'
      "Employee #{set_success_text} Successfully!"
    else
      # code here
    end
  end

  def set_success_text
    params[:action] == 'destroy' ? 'Deleted' : "#{params[:action].humanize}d"
  end

  def set_url
    case params[:controller]
    when 'cash_ups'
      cash_ups_url
    when 'users'
      users_url
    else
      # code here
    end
  end
end