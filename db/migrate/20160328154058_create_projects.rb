class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.text :description
      t.integer :status

      t.timestamps null: false
    end
  end
end
