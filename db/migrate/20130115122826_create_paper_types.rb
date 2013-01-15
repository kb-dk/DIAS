class CreatePaperTypes < ActiveRecord::Migration
  def change
    create_table :paper_types do |t|
      t.string :title
      t.integer :order
      t.text :description

      t.timestamps
    end
  end
end
