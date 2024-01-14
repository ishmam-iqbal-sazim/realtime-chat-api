class Api::V1::ServerEventsController < ApplicationController
    include ActionController::Live
    skip_before_action :doorkeeper_authorize!

    @@connections = {}

    def index
        response.headers['Content-Type'] = 'text/event-stream'
        response.headers['Connection'] = 'keep-alive'
        response.headers['Cache-Control'] = 'no-cache'
        response.headers['Last-Modified'] = Time.now.httpdate

        user_id = params[:id] 

        sse = SSE.new(response.stream, retry: 300, event: "open")
        @@connections[user_id] = sse

        begin
            loop do
                sleep 2
                puts "all keys: #{@@connections.keys}"
                sse.write({ message: "Helo from server"}, event: "message", retry: 5000)
                sleep 2
            end
        rescue ActionController::Live::ClientDisconnected
            @@connections.delete(user_id)
        ensure
            sse.close
        end
    end
end
