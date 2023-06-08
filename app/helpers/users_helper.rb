module UsersHelper
  def set_submit_btn_text(action)
    return 'Create Employee' if action == 'new'

    'Update Employee'
  end

  def set_submit_route(action)
    return '/create/employee' if action == 'new'

    '/update/employee'
  end

  def set_submit_method(action)
    return :post if action == 'new'

    :put
  end

  def labour_worker
    User.roles.reject { |role| role == 'super_admin' || role == 'admin' }.keys.map { |role| role.humanize }
  end
end
