class Project < ActiveRecord::Base
	belongs_to :user, :dependent => :destroy
	belongs_to :project, :dependent => :destroy
end