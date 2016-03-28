class CreateHistoricals < ActiveRecord::Migration
  def change
    create_table :historicals do |t|
      t.integer :type
      t.references :activity, index: true, foreign_key: true
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
