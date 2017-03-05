class AddSubToUser < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :sub, :string
    add_index :users, :sub
  end
end
