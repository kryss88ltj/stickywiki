class AddIdsToCollaboration < ActiveRecord::Migration
  def change
    add_column :collaborations, :user_id, :integer
    add_column :collaborations, :wiki_id, :integer
  end
end
