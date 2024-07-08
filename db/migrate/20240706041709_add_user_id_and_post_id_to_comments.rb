class AddUserIdAndPostIdToComments < ActiveRecord::Migration[6.1]
  def change
    # Check if the columns already exist before adding them
    unless column_exists?(:comments, :user_id)
      add_column :comments, :user_id, :integer
    end

    unless column_exists?(:comments, :post_id)
      add_column :comments, :post_id, :integer
    end

    # Check if the indices already exist before adding them
    unless index_exists?(:comments, :user_id)
      add_index :comments, :user_id
    end

    unless index_exists?(:comments, :post_id)
      add_index :comments, :post_id
    end
  end
end
