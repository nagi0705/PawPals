class AddKindToPets < ActiveRecord::Migration[6.1]
  def change
    add_column :pets, :kind, :string
  end
end
