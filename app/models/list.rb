class List < ActiveRecord::Base
  belongs_to :project

  validates :name, presence: true, length: { in: 1..17 }
  
  has_many :tasks, :dependent => :destroy
  
 # include PublicActivity::Model
	# tracked
end
