class TimelinesController < ApplicationController

  SLICE_SIZE = 100

  def show
    def get_all_friends(screen_name)
      client = twitter_client
      all_friends = []
      client.friend_ids(screen_name).each_slice(SLICE_SIZE).each do |slice|
        client.users(slice).each do |friend|
          all_friends << friend
        end
      end
      all_friends
    end

    friends = get_all_friends("moriko_o")
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
