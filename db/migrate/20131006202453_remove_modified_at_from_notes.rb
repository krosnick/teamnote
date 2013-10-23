class RemoveModifiedAtFromNotes < ActiveRecord::Migration
  def change
    remove_column :notes, :modified_at, :datetime
  end
end
