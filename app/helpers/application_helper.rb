module ApplicationHelper
  def active_class(param)
    return 'active' if controller_name == param
  end
end
