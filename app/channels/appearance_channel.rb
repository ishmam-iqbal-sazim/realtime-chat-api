class AppearanceChannel < ApplicationCable::Channel
  def subscribed
    stream_from "user_appearance"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
