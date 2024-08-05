class AddWeightToHealthRecords < ActiveRecord::Migration[6.1]
  def change
    add_column :health_records, :weight, :float
  end
end
