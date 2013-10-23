class CreateNotes < ActiveRecord::Migration
  def change
    create_table :notes do |t|
      t.string :content
      t.string :title
      t.datetime :modified_at

      t.timestamps
    end
  end
end
