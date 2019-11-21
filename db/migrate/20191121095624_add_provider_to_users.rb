class AddProviderToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :provider, :string
    add_column :users, :uid, :string
    add_column :users, :refresh_token, :string
    add_column :users, :token, :string
    add_column :users, :expires_at, :datetime
    add_column :users, :name, :string
    add_column :users, :google_app_id, :string
    add_column :users, :channel_id, :string
  end
end
