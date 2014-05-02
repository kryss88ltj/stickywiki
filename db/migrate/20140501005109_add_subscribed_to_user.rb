class AddSubscribedToUser < ActiveRecord::Migration
  def change
    add_column :users, :subscribed, :boolean
    add_column :users, :subscription_id, :boolean
  end
end
