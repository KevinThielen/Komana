class Project < ActiveRecord::Base

	has_many :lists, :dependent => :destroy
	has_and_belongs_to_many :users

	validates :name, presence: true, length: { minimum: 5 }
	
	 #include PublicActivity::Model
	 #tracked
end
