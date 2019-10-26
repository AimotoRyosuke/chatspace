class MessagesController < ApplicationController

  def index
    @messages = Message.includes(:group, :user)
    @group = Group.find(params[:group_id])
    @message = Message.new
  end


  def create
    @message = @group.messages.new(message_params)
    if @message.save
      redirect_to group_messages_path(@group), notice: 'メッセージが送信されました'
    else
      @messages = @group.messages.includes(:user)
      flash.now[:alert] = 'メッセージを入力してください。'
      render :index
    end
  end

  private
  def message_params
  end

  def set_group
    @group = Group.find(params[:group_id])
  end

end