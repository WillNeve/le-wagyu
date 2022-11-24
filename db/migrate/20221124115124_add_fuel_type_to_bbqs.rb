class AddFuelTypeToBbqs < ActiveRecord::Migration[7.0]
  def change
    add_column :bbqs, :fuel_type, :string
  end
end
