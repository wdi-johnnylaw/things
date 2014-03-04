class AddUpdatedAtIndexToOpinions < ActiveRecord::Migration
  def change
    add_index :opinions, :updated_at
  end
end
