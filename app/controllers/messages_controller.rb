class MessagesController < ApplicationController
  def index
    @messages = Message.all
    @new_message = Message.new
  end

  def create
    @new_message = Message.new(message_params)
    if @new_message.save
      redirect_to messages_path
    else
      render :index
    end
  end

  private

  def message_params
    params.require(:message).permit(:content)
  end
end
