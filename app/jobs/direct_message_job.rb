class DirectMessageJob < ApplicationJob
  queue_as :default

  def perform(message, sender_id, receiver_id)
    ActionCable.server.broadcast "private_#{receiver_id}_#{sender_id}", message
    ActionCable.server.broadcast "private_#{sender_id}_#{receiver_id}", message
  end
end
