class AddSlugToBoards < ActiveRecord::Migration[7.0]
  def change
    add_column :boards, :slug, :string
    add_index :boards, :slug, unique: true
  end
end
