class Restaurant < ApplicationRecord
  validates_presence_of :name

  mount_uploader :image, PhotoUploader

  belongs_to :category

  has_many :comments, dependent: :destroy

  # 「餐廳被很多人收藏」的多對多關聯
  # 將關聯名稱自訂為 :favorited_users
  # 自訂名稱後，Rails 無法自動推論來源名稱，需另加 source 告知 model name
  has_many :favorites, dependent: :destroy
  has_many :favorited_users, through: :favorites, source: :user

  # like
  has_many :likes, dependent: :destroy
  has_many :like_users, through: :likes, source: :user 

  def is_favorited?(user)
    self.favorited_users.include?(user)
  end

  def is_like?(user)
    self.like_users.include?(user)
  end

end
