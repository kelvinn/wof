class CreateNames < ActiveRecord::Migration
  def up
    create_table :names do |t|
      t.string :full_name
      t.string :twitter

      t.timestamps
    end
  end

  def down
    drop_table :names
  end
end