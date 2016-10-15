class CreateInsiders < ActiveRecord::Migration[5.0]
  def change
    create_table :insiders do |t|
      t.string :name
      t.string :relationship
      t.references :company

      t.timestamps
    end
  end
end
