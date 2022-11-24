class AddAddressToBbqs < ActiveRecord::Migration[7.0]
  def change
    add_column :bbqs, :address, :string
  end
end
