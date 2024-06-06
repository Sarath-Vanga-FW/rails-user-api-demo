class CreateAccounts < ActiveRecord::Migration[7.1]
  def change
    create_table :accounts do |t|
      t.string :name
      t.string :email
      t.string :address

      t.timestamps
    end
  end
end
