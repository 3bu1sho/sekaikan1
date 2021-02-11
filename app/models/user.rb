class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         
  has_many :sekais, dependent: :destroy
  
  def self.search_for(content, method)
    Sekai.where('name LIKE ?', '%'+content+'%')
  end
end
