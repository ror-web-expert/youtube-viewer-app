class ChangePostsDefaultStatusValue < ActiveRecord::Migration[7.0]
  def change
    change_column :posts, :status, :string, :default => "published"
  end
end
