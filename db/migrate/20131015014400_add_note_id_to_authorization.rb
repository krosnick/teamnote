class AddNoteIdToAuthorization < ActiveRecord::Migration
  def change
    add_column :authorizations, :note_id, :integer
  end
end
