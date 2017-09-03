class TwitterClient
  SLICE_SIZE = 100

  def initialize
    @client = Twitter::REST::Client.new do |config|
      config.consumer_key = Rails.application.secrets.consumer_key
      config.consumer_secret = Rails.application.secrets.consumer_secret
      config.access_token = Rails.application.secrets.access_token
      config.access_token_secret = Rails.application.secrets.access_token_secret
    end
  end

  def all_friends(screen_name)
    all_friends = []
    @client.friend_ids(screen_name).each_slice(SLICE_SIZE).each do |slice|
      @client.users(slice).each do |friend|
        all_friends << friend
      end
      break
    end
    all_friends
  end
end
