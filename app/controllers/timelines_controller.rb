class TimelinesController < ApplicationController
  def show
    friends = TwitterClient.new.all_friends("moriko_o")
    @timeline = friends.find_all{|user| user.status.created_at.present? }.map(&:status).sort_by(&:created_at).reverse

    tweets = @timeline.map do |tweet|
      #Rails.logger.debug tweet.text.match(/http/)
      #tweet.text.match(/http/).compact.map { |i| i(i) }
    end
  end

  private
end
