class Project < ActiveRecord::Base

	validates :name, presence: true

	has_many :lists, :dependent => :destroy
	has_and_belongs_to_many :users
	
	 include PublicActivity::Model
	 tracked
end
