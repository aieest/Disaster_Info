class Post < ApplicationRecord
 validates :title, presence: true
 validates :content, presence: true

 belongs_to :user
 mount_uploader :image, ImageUploader
 has_many :comments
 has_many :post_category_ships
 has_many :categories, through: :post_category_ships
 def destroy
  update(deleted_at: Time.now)
 end
 def comment_count
  self.comments.count
 end

 scope :top_posts, -> { left_joins(:comments).group(:id).order('COUNT(comments.id) DESC').limit(3) }
end