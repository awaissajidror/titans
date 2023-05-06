module ResponseAble
  extend ActiveSupport::Concern

  included do
    # code to be executed when the module is included in a class
  end

  class_methods do
    # class-level methods go here
  end

  def success_response
    flash[:success] = "CashUp #{set_success_text} Successfully!"
    redirect_to cash_ups_url
  end

  def error_response
    flash[:error] = "CashUp Didn't Created Successfully!"
    render params[:action] == 'update' ? :edit : :new
  end

  def set_success_text
    params[:action] == 'destroy' ? 'Deleted' : params[:action].humanize
  end
end