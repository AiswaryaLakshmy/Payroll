class ChangeEncryptedSalaryInUser < ActiveRecord::Migration
  def change
  	change_column :users, :encrypted_salary, :string
  end
end
