class Favorite < ApplicationRecord
    belongs_to :user
	belongs_to :sekai
	validates_uniqueness_of :sekai_id, scope: :user_id    
end
