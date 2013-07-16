class IndexController < ApplicationController
  def index
    Instagram.configure do |config|
        config.client_id = '4450080f39ce4657981253a4a9380486'
        config.access_token = Rails.cache.read('instagram_token')
    end
    if params['query']
      if current_user and Rails.cache.read('instagram_token')
        # @photos = Instagram.user_recent_media('16213907', {count: 5})
        @query = params['query']
        @photos = Instagram.tag_recent_media(params['query'] ,{count: 12})
      end
    end
  end

  def post_facebook

    @graph = Koala::Facebook::API.new(session[:facebook_token])
    @graph.put_picture(params['src'], {:message => params['comment']})
    
    redirect_to :back,:flash => {:notice => "facebookに投稿しました。"}
  end
end
