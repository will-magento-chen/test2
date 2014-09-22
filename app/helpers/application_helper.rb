module ApplicationHelper
  def active_class(param)
    return 'active' if controller_name == param
  end

  def magento_url(action = '')
    ENV['BAREFOOT_MAGENTO_URL'] + '/' + action
  end

  def barefoot_sign_in_url
    ENV['BAREFOOT_SIGN_IN_URL']
  end

  def barefoot_sign_out_url
    ENV['BAREFOOT_SIGN_OUT_URL']
  end
end
