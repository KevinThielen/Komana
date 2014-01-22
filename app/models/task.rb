class Task < ActiveRecord::Base

	#validates :priority, :inclusion => { :in => %w{low medium high} }
  
  	belongs_to :list
  	has_and_belongs_to_many :users
end
