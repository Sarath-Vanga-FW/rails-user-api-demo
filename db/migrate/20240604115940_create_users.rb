class CreateUsers < ActiveRecord::Migration[7.1]
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :role
      t.references :account, null: false, foreign_key: true

      t.timestamps
    end
  end
end
