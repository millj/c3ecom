class AddDescriptionToAllocationOrderLine < ActiveRecord::Migration
  def change
    add_column :allocation_order_lines, :description, :string
  end
end
