class Post < ApplicationRecord
  belongs_to :user
  belongs_to :group
  has_many :comments, dependent: :destroy

  validates :title, presence: true
  validates :content, presence: true
  mount_uploader :image, ImageUploader

  def self.search(search)
    if search
      where('title LIKE ? OR content LIKE ?', "%#{search}%", "%#{search}%")
    else
      all
    end
  end
end
