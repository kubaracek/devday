class CreateEnterpriseConfigurations < ActiveRecord::Migration[5.1]
  def up
    create_table :enterprise_configurations do |t|
      t.string :app_name
      t.string :subdomain
      t.integer :organization_id
      t.timestamps
    end
    add_index :enterprise_configurations, :organization_id
  end

  def down
    drop_table :enterprise_configurations
  end
end
