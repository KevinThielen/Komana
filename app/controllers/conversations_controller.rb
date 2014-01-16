class ConversationsController < ApplicationController
  before_filter :authenticate_user!
  helper_method :mailbox, :conversation

  def create
  
   raise
	if params[:reply]
		raise
	end
    

    recipient_emails = conversation_params(:recipients)
    recipients = User.where(email: recipient_emails).all

    conversation = current_user.
    send_message(recipients, *conversation_params(:body, :subject)).conversation

    redirect_to conversations_path
  end

  def reply
	current_conversation = Conversation.find(params[:conversation_id])
    current_user.reply_to_conversation(current_conversation, params[:body])
    redirect_to conversation_path(current_conversation)
  end

  def trash
    conversation.move_to_trash(current_user)
    redirect_to :conversations
  end

  def untrash
    conversation.untrash(current_user)
    redirect_to :conversations
  end

  private

  def mailbox
    @mailbox ||= current_user.mailbox
  end

  def conversation
    @conversation ||= mailbox.conversations.find(params[:id])
  end

  def conversation_params(*keys)
    fetch_params(:conversation, *keys)
  end

  def message_params(*keys)
    fetch_params(:message, *keys)
  end

  def fetch_params(key, *subkeys)
    params[key].instance_eval do
      case subkeys.size
      when 0 then self
      when 1 then self[subkeys.first]
      else subkeys.map{|k| self[k] }
      end
    end
  end
end
