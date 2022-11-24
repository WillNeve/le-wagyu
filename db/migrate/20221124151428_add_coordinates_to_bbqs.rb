class AddCoordinatesToBbqs < ActiveRecord::Migration[7.0]
  def change
    add_column :bbqs, :latitude, :float
    add_column :bbqs, :longitude, :float
  end
end
