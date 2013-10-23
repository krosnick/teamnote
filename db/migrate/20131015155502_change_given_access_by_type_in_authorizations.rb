class ChangeGivenAccessByTypeInAuthorizations < ActiveRecord::Migration
  def change
  	change_column :authorizations, :given_access_by, :integer
  end
end
