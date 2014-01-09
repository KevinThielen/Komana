class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

        acts_as_messageable
        
        def name
          email
        end
        #Returning the email address of the model if an email should be sent for this object (Message or Notification).
        #If no mail has to be sent, return nil.
        def mailboxer_email(object)
        #Check if an email should be sent for that object
        #if true
        return email
        #if false
        #return nil
        end
end
