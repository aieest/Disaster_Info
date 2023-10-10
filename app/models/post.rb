class Post < ApplicationRecord
 validates :title, presence: true
 validates :content, presence: true

 belongs_to :user
 has_many :comments
 has_many :post_category_ships
 has_many :categories, through: :post_category_ships
 def destroy
  update(deleted_at: Time.now)
 end
end