class TimelinesController < ApplicationController

  def show
    friends = twitter_client.friends("moriko_o", count: 5000)
    @timeline = friends.find_all{|user| user.status.created_at.present? }.map(&:status).sort_by(&:created_at).reverse
  end

  def twitter_client
    Twitter::REST::Client.new do |config|
      config.consumer_key        = ''
      config.consumer_secret     = ''
      config.access_token        = ''
      config.access_token_secret = ''
    end
  end


end
