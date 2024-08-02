class AddBirthDateFieldsToPets < ActiveRecord::Migration[6.1]
  def change
    add_column :pets, :birth_year, :integer
    add_column :pets, :birth_month, :integer
    add_column :pets, :birth_day, :integer
  end
end
