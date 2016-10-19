class CreateForms < ActiveRecord::Migration[5.0]
  def change
    create_table :forms do |t|
      t.string :date
      t.string :dcn
      t.string :sec_form_url
      t.references :insider
      t.references :transactions

      t.timestamps
    end
  end
end
