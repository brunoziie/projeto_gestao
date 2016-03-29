class AddResponsibilityToUsers < ActiveRecord::Migration
  def change
    add_column :users, :responsibility, :integer
  end
end
