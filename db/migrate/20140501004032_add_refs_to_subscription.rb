class AddRefsToSubscription < ActiveRecord::Migration
  def change
    add_column :subscriptions, :plan_id, :integer
    add_column :subscriptions, :user_id, :integer
  end
end
