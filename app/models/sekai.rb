class Sekai < ApplicationRecord
      belongs_to :user
      
	has_many :favorites, dependent: :destroy
	has_many :comments, dependent: :destroy
      
      has_many :tag_maps, dependent: :destroy
      has_many :tags, through: :tag_maps
      
      attachment :image
      
	def favorited_by?(user)
		favorites.where(user_id: user.id).exists?
	end      
	
	
  def save_tag(sent_tags)
    current_tags = self.tags.pluck(:tag_name) unless self.tags.nil?
    old_tags = current_tags - sent_tags
    new_tags = sent_tags - current_tags
  
    old_tags.each do |old|
      self.tag_maps.delete Tag.find_by(tag_name: old)
    end
  
    new_tags.each do |new|
      new_tag_map = Tag.find_or_create_by(tag_name: new)
      self.tag_maps << new_tag_map
    end
  end
  
  
  def self.search_for(content)
    Sekai.where('name LIKE ?', '%'+content+'%')
  end
  
end
