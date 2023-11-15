class AddLocationIdToPosts < ActiveRecord::Migration[7.0]
  def change
    add_reference :posts, :location, foreign_key: true
  end
end
