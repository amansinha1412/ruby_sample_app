class AddAdditionalDetailsToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :additional_details, :string
  end
end
