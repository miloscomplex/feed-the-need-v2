class CreateItems < ActiveRecord::Migration[6.0]
  def change
    create_table :items do |t|
      t.string :name
      t.integer :quantity
      t.string :donator_id
      t.string :needy_id
      t.timestamps
    end
  end
end
