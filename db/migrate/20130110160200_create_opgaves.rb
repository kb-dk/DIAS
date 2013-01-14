class CreateOpgaves < ActiveRecord::Migration
  def change
    create_table :opgaves do |t|

      t.timestamps
    end
  end
end
