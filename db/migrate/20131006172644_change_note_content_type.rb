class ChangeNoteContentType < ActiveRecord::Migration
  def change
  	change_column :notes, :content, :text, :limit => nil
  end
end
