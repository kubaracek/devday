class CreateEnterpriseConfigurations < ActiveRecord::Migration[5.1]
  def change
    create_table :enterprise_configurations do |t|
      t.string :app_name
      t.string :subdomain
      t.integer :organization_id

      t.timestamps
    end
  end
end
