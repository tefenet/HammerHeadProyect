class MessagesController < ApplicationController

  def new
    @message = Message.new
  end

  def create
    @message = Message.new message_params

    if @message.valid?
      redirect_to new_message_url, notice: "Mensaje recibido, gracias!"
    else
      render :new
    end
  end

  private

  def message_params
    params.require(:message).permit(:nombre, :email, :mensaje)
  end
end
