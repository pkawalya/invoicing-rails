class CreateBankAccounts < ActiveRecord::Migration[7.1]
  def change
    create_table :bank_accounts do |t|
      t.string :name
      t.string :account_number
      t.decimal :balance

      t.timestamps
    end
  end
end
