class Project < ActiveRecord::Base
	has_many :lists, :dependent => :destroy
	has_and_belongs_to_many :users
end
