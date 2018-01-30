class Friendship < ApplicationRecord
  validates :friend_id, uniqueness: { scope: :user_id }
  # 這筆追蹤紀錄，屬於發出'加別人好友'的user
  belongs_to :user 
  # 這筆追蹤紀錄，屬於'被加'的user
  belongs_to :friend, class_name: "User"
end
