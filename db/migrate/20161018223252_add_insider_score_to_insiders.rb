class AddInsiderScoreToInsiders < ActiveRecord::Migration[5.0]
  def change
    add_column :insiders, :insider_score, :integer
  end
end
