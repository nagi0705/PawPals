class Group < ApplicationRecord
  has_many :group_memberships, dependent: :destroy
  has_many :users, through: :group_memberships
  has_many :posts
  has_many :messages

  validates :name, presence: true
  validates :description, presence: true
end
