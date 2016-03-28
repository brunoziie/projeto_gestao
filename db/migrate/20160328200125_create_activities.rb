class CreateActivities < ActiveRecord::Migration
  def change
    create_table :activities do |t|
      t.string :name
      t.text :description
      t.datetime :init_time
      t.datetime :finish_time
      t.integer :estimate
      t.integer :status
      t.references :user, index: true, foreign_key: true
      t.references :sprint, index: true, foreign_key: true
      t.references :project, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
