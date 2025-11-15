class AddHandleNameToUsers < ActiveRecord::Migration[8.0]
  def change
    add_column :users, :handle_name, :string
  end
end
