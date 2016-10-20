class CreateImages < ActiveRecord::Migration[5.0]
  def change
    create_table :images do |t|
      t.string :img_path
      t.references :company, foreign_key: true

      t.timestamps
    end
  end
end
