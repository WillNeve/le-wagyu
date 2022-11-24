class AddStyleTypeToBbqs < ActiveRecord::Migration[7.0]
  def change
    add_column :bbqs, :style_type, :string
  end
end
