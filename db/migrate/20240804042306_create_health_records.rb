class CreateHealthRecords < ActiveRecord::Migration[6.1]
  def change
    create_table :health_records do |t|
      t.references :pet, null: false, foreign_key: true
      t.boolean :walked, default: false, null: false
      t.boolean :morning_meal, default: false, null: false
      t.boolean :evening_meal, default: false, null: false
      t.text :note

      t.timestamps
    end
  end
end
