class Task < ActiveRecord::Base

  belongs_to :list
  has_and_belongs_to_many :users

  validates :name, presence: true, length: { minimum: 3 }
  validates :priority, :inclusion => { :in => %w{low medium high} }, :allow_nil => true
  
  #include PublicActivity::Model
	# tracked
  
end
