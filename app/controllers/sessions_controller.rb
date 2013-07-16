class SessionsController < ApplicationController
  def create
    auth = request.env["omniauth.auth"]
    user = User.find_by_provider_and_uid(auth["provider"], auth["uid"]) || User.create_with_omniauth(auth)
    if auth['provider'] == 'facebook'
      session[:facebook_token] = auth.credentials.token
      session[:facebook_token_secret] = auth.credentials.secret
    elsif auth['provider'] == 'instagram'
      Rails.cache.write 'instagram_token', auth.credentials.token
    end
    #@graph = Koala::Facebook::API.new(auth.credentials.token)
    #@graph.put_picture('http://distilleryimage1.s3.amazonaws.com/e574849ced0811e2b23022000a1f9ad5_6.jpg', {:message => "test"})
    session[:user_id] = user.id
    redirect_to root_url, :notice => "Signed In!"
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url, :notice => "Signed Out!"
  end
end
