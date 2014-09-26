require 'net/http'
require 'digest/md5'


class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_filter :transfer_session

  include ApplicationHelper

  protected
  def transfer_session
    headers["Access-Control-Allow-Origin"] = "*"
    session_check_url = ENV['BAREFOOT_SESSION_CHECK_URL']
    php_session = request.cookies['PHPSESSID']

    return if current_user && php_session && php_session == session[:php_session_id]

    if php_session
      timestamp = Time.now.to_i
      token = Digest::MD5.hexdigest("#{timestamp} at #{php_session}")
      url = URI.parse("#{session_check_url}?sid=#{php_session}&token=#{token}&t=#{timestamp}")
      req = Net::HTTP::Get.new(url.to_s)
      res = Net::HTTP.start(url.host, url.port) {|http|
        http.request(req)
      }
      remote_user = JSON.parse(res.body.to_s).with_indifferent_access

      if remote_user[:entity_id] || remote_user[:c5_id]
        user = User.where(magento_id: remote_user[:entity_id]).first ||
               User.where(c5_id: remote_user[:c5_id]).first ||
               User.where(email: remote_user[:email]).first

        if user.nil?
          user = User.new 
          user.password = (0...20).map { ('a'..'z').to_a[rand(26)] }.join
          user.password_confirmation = user.password
        end
        name = [remote_user[:firstname], remote_user[:middlename], remote_user[:lastname], remote_user[:last_name]].compact.join(" ")
        user.name       = name unless(name.blank?)
        user.email      = remote_user[:email]     || user.email
        user.magento_id = remote_user[:entity_id] || user.magento_id
        user.c5_id      = remote_user[:c5_id]     || user.c5_id
        user.save!

        session[:php_session_id] = php_session
        sign_in(user)
      end
    end
  end

end
