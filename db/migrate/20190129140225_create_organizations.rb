class CreateOrganizations < ActiveRecord::Migration[5.1]
  def up
    create_table :organizations do |t|
      t.string :name
      t.string :secret
      t.integer :user_id
      t.timestamps
    end
    add_index :organizations, :user_id
  end

  def down
    drop_table :organizations
  end
end
