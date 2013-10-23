class CreateAuthorizations < ActiveRecord::Migration
  def change
    create_table :authorizations do |t|
      t.string :access
      t.string :given_access_by

      t.timestamps
    end
  end
end
