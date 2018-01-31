class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  
  validates_presence_of :name

  mount_uploader :avatar, AvatarUploader
  
  # 如果 User 已經有了評論，就不允許刪除帳號（刪除時拋出 Error）
  has_many :comments, dependent: :restrict_with_error
  # 「使用者評論很多餐廳」的多對多關聯
  has_many :restaurants, through: :comments

  # 「使用者加入我的最愛」的多對多關聯
  # 由於使用 restaurants 會和「使用者評論很多餐廳」重覆，將關聯名稱自訂為 :favorited_restaurants
  # 自訂名稱後，Rails 無法自動推論來源名稱，需另加 source 告知 model name
  has_many :favorites, dependent: :destroy
  has_many :favorited_restaurants, through: :favorites, source: :restaurant

   # like
  has_many :likes, dependent: :destroy
  has_many :like_users, through: :likes, source: :user 

  # 「使用者追蹤使用者」的 self-referential relationships 設定
  # 不需要另加 source，Rails 可從 Followship Model 設定來判斷 followings 指向 User Model
  has_many :followships, dependent: :destroy
  has_many :followings, through: :followships

   # 「使用者的追蹤者」的設定
   # 透過 class_name, foreign_key 的自訂，指向 Followship 表上的另一側
  has_many :inverse_followships, class_name: "Followship", foreign_key: "following_id"
  has_many :followers, through: :inverse_followships, source: :user

  #  一個user有很多朋友關係紀錄(這裏朋友關係指被加為好友) 
  has_many :friendships, dependent: :destroy
  # 一個user有很多加別人好友的紀錄
  has_many :friends, through: :friendships
  
  # admin? 讓我們用來判斷單個user是否有 admin 角色，列如：current_user.admin?
  def admin?
    self.role == "admin"
  end
  
  # 判斷此使用者本身
  def following?(user)
    self.followings.include?(user)
  end

  # 判斷使用者是自己本身，並隱藏交友按鈕
  def friend?(user)
    self.friends.include?(user)
  end
  
end
