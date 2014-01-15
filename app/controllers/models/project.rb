class Project < ActiveRecord::Base
	has_many :lists, :order => "position ASC"
end
