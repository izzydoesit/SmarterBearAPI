class CreateTransactions < ActiveRecord::Migration[5.0]
  def change
    create_table :transactions do |t|
      t.string :direction
      t.float :total_value
      t.float :price_per_share
      t.integer :shares_transacted
      t.string :date
      t.references :insider, foreign_key: true
      t.references :company, foreign_key: true

      t.timestamps
    end
  end
end
