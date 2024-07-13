# This migration comes from graph_ql_authentication (originally 20190108151146)
class AddRefreshTokenToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :refresh_token, :string, default: nil
  end
end
