class CreateBbqs < ActiveRecord::Migration[7.0]
  def change
    create_table :bbqs do |t|
      t.float :price
      t.string :title
      t.text :description
      t.string :location
      t.string :manufacturer
      t.references :user, null: false, foreign_key: true
      t.boolean :active

      t.timestamps
    end
  end
end
