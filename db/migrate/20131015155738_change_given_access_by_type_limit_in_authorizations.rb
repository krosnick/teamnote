class ChangeGivenAccessByTypeLimitInAuthorizations < ActiveRecord::Migration
  def change
  	change_column :authorizations, :given_access_by, :integer, :limit => nil
  end
end
