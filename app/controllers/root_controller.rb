class RootController < ApplicationController
  def login
    redirect_to barefoot_sign_in_url
  end

  def logout
    sign_out
    redirect_to barefoot_sign_out_url
  end
end
