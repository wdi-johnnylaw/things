class CreateThings < ActiveRecord::Migration
  def change
    create_table :things do |t|
      t.string :name
      t.text :description
      t.string :image_url

      t.timestamps
    end

    add_index :things, :name
  end
end
