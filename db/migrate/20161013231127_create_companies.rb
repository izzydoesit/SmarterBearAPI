class CreateCompanies < ActiveRecord::Migration[5.0]
  def change
    create_table :companies do |t|
      t.string :name
      t.string :ticker
      t.integer :cik_number
      t.integer :shares_outstanding, :limit => 8
      t.integer :confidence_rating

      t.timestamps
    end
  end
end
