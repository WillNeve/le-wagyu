class AddCookingAreaToBbqs < ActiveRecord::Migration[7.0]
  def change
    add_column :bbqs, :cooking_area, :string
  end
end
