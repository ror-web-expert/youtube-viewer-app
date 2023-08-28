class CreateJobDetails < ActiveRecord::Migration[7.0]
  def change
    create_table :job_details do |t|
      t.references :job_listing, null: false, foreign_key: true
      t.string :title
      t.string :scraped_url
      t.boolean :is_scrap, default: 0
      t.integer :status, default: :pending
      t.jsonb :response_data, default: {}

      t.timestamps
    end
  end
end
