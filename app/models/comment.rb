class Comment < ApplicationRecord
  validates_presence_of :content
  belongs_to :restaurant
  belongs_to :user
end
