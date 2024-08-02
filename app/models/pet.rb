class Pet < ApplicationRecord
  belongs_to :user

  has_one_attached :image

  validates :name, presence: { message: '名前を入力してください' }
  validates :species, presence: { message: '種類を入力してください' }
  validates :birth_year, presence: { message: '生年を入力してください' }
  validates :birth_month, presence: { message: '月を入力してください' }
  validates :birth_day, presence: { message: '日を入力してください' }
  validates :kind, presence: { message: 'カラーを入力してください' }

  def age
    return unless birth_year && birth_month && birth_day

    birth_date = Date.new(birth_year, birth_month, birth_day)
    now = Time.zone.now
    age_years = now.year - birth_date.year
    age_months = now.month - birth_date.month

    if now.month < birth_date.month || (now.month == birth_date.month && now.day < birth_date.day)
      age_years -= 1
      age_months += 12
    end

    age_months = (now.month - birth_date.month) % 12
    "#{age_years}歳#{age_months}ヶ月"
  end
end