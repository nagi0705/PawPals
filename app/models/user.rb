class User < ApplicationRecord
  # Deviseの設定
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :group_memberships
  has_many :groups, through: :group_memberships

  def self.guest
    find_or_create_by!(email: 'guest@example.com') do |user|
      user.password = SecureRandom.urlsafe_base64
    end
  end

  def self.search(search)
    if search
      where('email LIKE ?', "%#{search}%")
    else
      all
    end
  end
end
