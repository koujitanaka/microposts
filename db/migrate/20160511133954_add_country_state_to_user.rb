class AddCountryStateToUser < ActiveRecord::Migration
  def change
    add_column :users, :country, :string
    add_column :users, :profile, :string
  end
end
