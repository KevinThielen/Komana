class Task < ActiveRecord::Base

  belongs_to :list
  has_and_belongs_to_many :users

  validates :titel, presence: true, length: { minimum: 3 }
  validates :text, length: { maximum: 512 }
  validates :priority, :inclusion => { :in => %w{low medium high} }
  
  #include PublicActivity::Model
	# tracked
  
end
