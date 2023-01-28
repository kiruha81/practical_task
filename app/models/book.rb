class Book < ApplicationRecord
  belongs_to :user
  has_many :favorites, dependent: :destroy
  has_many :bads, dependent: :destroy
  has_many :book_comments, dependent: :destroy
  has_one_attached :image
  validates :title, presence:true
  validates :body, presence:true
  validates :body, length: { maximum: 200 }

  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
  end

  def baded_by?(user)
    bads.exists?(user_id: user.id)
  end
end
