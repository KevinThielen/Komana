class ConversationsController < ApplicationController
  before_filter :authenticate_user!
  helper_method :mailbox, :conversation

  def create

    #macht paar Probleme: flash zeigt error an ?! (We're sorry, but something went wrong.)
    @user = User.where("email = ?", params[:recipients]).first
    if @user.present?

      recipient_emails = conversation_params(:recipients)
      recipients = User.where(email: recipient_emails).all

      conversation = current_user.send_message(recipients, *conversation_params(:body, :subject)).conversation
  	  flash[:notice] = "Die Nachricht wurde erfolgreich gesendet."
	
      redirect_to conversations_path

    else 
      #flash[:error] = "Dieser Benutzer existiert nicht, bitte prüfen sie ihre Eingabe"
      redirect_to new_conversation_path
    end
  end
  

  def index
	 
  end
  
  def reply
	    current_conversation = Conversation.find(params[:conversation_id])
      current_user.reply_to_conversation(current_conversation, params[:body])
      redirect_to conversation_path(current_conversation)
      flash[:notice] = "Die Antwort wurde erfolgreich gesendet."

  end

  def trash
      current_conversation = Conversation.find(params[:conversation_id])
      current_user.trash(current_conversation)    

      redirect_to conversations_path
  end

  def untrash
      current_conversation = Conversation.find(params[:conversation_id])
      current_user.untrash(current_conversation) 
      redirect_to :conversations
    end
  
  def mark_as_unread
      current_conversation = Conversation.find(params[:conversation_id])
      current_conversation.mark_as_unread(current_user)
      redirect_to conversations_path
  end
  
  def mark_as_read
      current_conversation = Conversation.find(params[:conversation_id])
      current_conversation.mark_as_read(current_user)
      redirect_to conversations_path
  end
  
  def delete
      current_conversation = Conversation.find(params[:conversation_id])
      current_conversation.mark_as_deleted(current_user)
      redirect_to conversations_path(:partial => 'conversations/trash')
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
