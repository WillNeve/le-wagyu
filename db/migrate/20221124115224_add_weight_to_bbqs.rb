class AddWeightToBbqs < ActiveRecord::Migration[7.0]
  def change
    add_column :bbqs, :weight, :string
  end
end
