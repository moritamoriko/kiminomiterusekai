class TimelinesController < ApplicationController
  SLICE_SIZE = 100

  def show
    friends = get_all_friends("moriko_o")
    @timeline = friends.find_all{|user| user.status.created_at.present? }.map(&:status).sort_by(&:created_at).reverse
  end

  private

  def twitter_client
    Twitter::REST::Client.new do |config|
      config.consumer_key = Rails.application.secrets.consumer_key
      config.consumer_secret = Rails.application.secrets.consumer_secret
      config.access_token = Rails.application.secrets.access_token
      config.access_token_secret = Rails.application.secrets.access_token_secret
    end
  end

  def get_all_friends(screen_name)
    client = twitter_client
    all_friends = []
    client.friend_ids(screen_name).each_slice(SLICE_SIZE).each do |slice|
      client.users(slice).each do |friend|
        all_friends << friend
      end
      break
    end
    all_friends
  end

end
