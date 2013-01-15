class CreateInstitutes < ActiveRecord::Migration
  def change
    create_table :institutes do |t|
      t.string :title
      t.integer :order
      t.text :description

      t.timestamps
    end
  end
end
