class CreateWorks < ActiveRecord::Migration[6.1]
  def change
    create_table :works do |t|
      t.integer :set
      t.integer :rep
      t.date :date
      t.references :exercise, null: false, foreign_key: true

      t.timestamps
    end
  end
end
