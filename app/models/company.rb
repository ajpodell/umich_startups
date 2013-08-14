class Company < ActiveRecord::Base
  	# attr_accessible :title, :user_id, :description, :mission
	belongs_to :user # REMOVE THIS
	validates :title, presence: true

	has_many :memberships, dependent: :destroy

end
