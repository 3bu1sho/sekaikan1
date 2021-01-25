class Comment < ApplicationRecord
    belongs_to :user
	belongs_to :sekai

	validates :comment, presence: true
end
