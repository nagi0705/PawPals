class CreateGrowthRecords < ActiveRecord::Migration[6.1]
  def change
    create_table :growth_records do |t|
      t.references :pet, null: false, foreign_key: true
      t.float :weight
      t.text :notes

      t.timestamps
    end
  end
end
