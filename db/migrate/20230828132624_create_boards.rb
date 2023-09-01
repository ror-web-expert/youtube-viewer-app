class CreateBoards < ActiveRecord::Migration[7.0]
  def change
    create_table :boards do |t|
      t.string :title
      t.string :source_url
      t.jsonb :listing_selector, default: {}
      t.jsonb :detail_selector, default: {}

      t.timestamps
    end
  end
end
