class AddEncryptedSalaryIvToUsers < ActiveRecord::Migration
  def change
    add_column :users, :encrypted_salary_iv, :string
  end
end
