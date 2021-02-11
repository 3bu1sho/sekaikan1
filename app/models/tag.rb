class Tag < ApplicationRecord
  has_many :tag_maps, dependent: :destroy, foreign_key: 'tag_id'
  has_many :sekais, through: :tag_maps
  
  def self.search_for(content)
    Tag.where('tag_name LIKE ?', '%'+content+'%')
  end  
end
