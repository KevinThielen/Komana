class List < ActiveRecord::Base
  belongs_to :project
  
  has_many :tasks, :dependent => :destroy
  
  include PublicActivity::Model
	 tracked
end
