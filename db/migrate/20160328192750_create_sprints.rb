class CreateSprints < ActiveRecord::Migration
  def change
    create_table :sprints do |t|
      t.integer :number
      t.text :description
      t.date :init_date
      t.date :end_date
      t.integer :status
      t.references :project

      t.timestamps null: false
    end
  end
end
