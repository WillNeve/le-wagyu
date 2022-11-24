class AddPowerToBbqs < ActiveRecord::Migration[7.0]
  def change
    add_column :bbqs, :power, :string
  end
end
