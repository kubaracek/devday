class CreateIps < ActiveRecord::Migration[5.1]
  def change
    create_table :ips do |t|
      t.string :cidr
      t.references :ipable, polymorphic: true

      t.timestamps
    end
  end
end
