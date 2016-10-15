class CreateTransactions < ActiveRecord::Migration[5.0]
  def change
    create_table :transactions do |t|
      t.string :date
      t.integer :dcn
      t.float :price
      t.string :sec_form_url
      t.string :transaction_type
      t.references :insider

      t.timestamps
    end
  end
end
