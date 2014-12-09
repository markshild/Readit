class CreateSubs < ActiveRecord::Migration
  def change
    create_table :subs do |t|
      t.string :title, null: false
      t.text :description
      t.integer :moderator, null: false

      t.timestamps
    end
    add_index :subs, :moderator
  end
end
