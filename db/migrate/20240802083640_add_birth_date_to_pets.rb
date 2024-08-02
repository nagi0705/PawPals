class AddBirthDateToPets < ActiveRecord::Migration[6.1]
  def change
    add_column :pets, :birth_date, :date
  end
end
