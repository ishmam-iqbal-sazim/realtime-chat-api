class ChatChannel < ApplicationCable::Channel
  def subscribed
    sender_id = params[:sender_id]
    receiver_id = params[:receiver_id]

    if sender_id && receiver_id
      stream_from "private_#{sender_id}_#{receiver_id}"
    else
      reject
    end

  end

  def unsubscribed
    stop_all_streams
  end
end
