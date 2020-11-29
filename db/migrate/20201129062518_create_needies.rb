class CreateNeedies < ActiveRecord::Migration[6.0]
  def change
    create_table :needies do |t|
      t.string :username
      t.string :password_digest
      t.string :name
      t.string :bio

      t.timestamps
    end
  end
end
