ActiveSupport.on_load(:active_record) do
  ActiveRecord::Base.connection.execute('SET NAMES utf8mb4 COLLATE utf8mb4_general_ci')
end
