class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  
  has_and_belongs_to_many :projects :dependent => :destroy
  has_and_belongs_to_many :tasks :dependent => :destroy

  validates :firstname, :lastname, :password_confirmation, presence: true
  validates :password, length: { in: 6..20 }
  validates :firstname, :lastname, length: { maximum: 20 }
  	
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
