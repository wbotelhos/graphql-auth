# This migration comes from graph_ql_authentication (originally 20190226175233)
class AddLockableToDevise < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :locked_at, :datetime
  end
end
