class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :username, presence: true, uniqueness: true

  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :group_memberships
  has_many :groups, through: :group_memberships
  has_many :messages, dependent: :destroy
  has_many :pets, dependent: :destroy

  def self.guest
    find_or_create_by!(email: 'guest@example.com') do |user|
      user.password = SecureRandom.urlsafe_base64
      user.username = 'ゲストユーザー'
    end
  end

  def self.search(search)
    if search
      where('username LIKE ?', "%#{search}%")
    else
      all
    end
  end
end
