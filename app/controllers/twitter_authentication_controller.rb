class TwitterAuthenticationController < ApplicationController
  def callback
    omniauth = request.env['omniauth.auth']
    omniauth.credentials.token
    omniauth.credentials.secret
  end
end
