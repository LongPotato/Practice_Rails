class AddCreatorIdToEvents < ActiveRecord::Migration
  def change
    add_column :events, :creator_id, :int
  end
end
