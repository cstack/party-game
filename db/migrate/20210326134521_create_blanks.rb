class CreateBlanks < ActiveRecord::Migration[6.1]
  def change
    create_table :blanks do |t|
      t.references :movie, null: false, foreign_key: true
      t.text :key
      t.text :value

      t.timestamps
    end
  end
end
