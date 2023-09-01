class CreatePosts < ActiveRecord::Migration[7.0]
  def change
    create_table :posts do |t|
      t.references :board, null: false, foreign_key: true
      t.string :title
      t.string :scraped_url
      t.boolean :is_scrap, default: 0
      t.string :status, default: "pending"
      t.jsonb :response_data, default: {}

      t.timestamps
    end
  end
end
