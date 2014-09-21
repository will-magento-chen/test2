module ApplicationHelper
  def active_class(param)
    return 'active' if controller_name == param
  end

  def magento_url(action = '')
    ENV['BAREFOOT_MAGENTO_URL'] + '/' + action
  end
end
