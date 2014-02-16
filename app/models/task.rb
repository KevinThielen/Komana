class Task < ActiveRecord::Base

  belongs_to :list
  has_and_belongs_to_many :users

  validates :name, presence: true, length: { minimum: 3 }
  
  #include PublicActivity::Model
	# tracked
	 

	validates :priority, :inclusion => { :in => %w{low medium high} }
  
end
