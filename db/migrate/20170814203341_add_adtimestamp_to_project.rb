class AddAdtimestampToProject < ActiveRecord::Migration
  def change
    add_column :projects, :ad_timestamp, :datetime
  end
end
