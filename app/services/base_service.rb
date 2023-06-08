class BaseService
  def self.call(*args)
    new(*args).call
  end

  # Common Methods for user
  def set_user_role
    case params[:role]
    when 'Employee'
      params[:role] = 3
    when 'Office worker'
      params[:role] = 4
    else
      # type code here
    end
  end
end