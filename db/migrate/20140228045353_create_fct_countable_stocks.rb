class CreateFctCountableStocks < ActiveRecord::Migration
  def change
    create_table :fct_countable_stocks do |t|
      t.string :location
      t.string :bin_code
      t.integer :exclude_from_standard

      t.timestamps
    end
  end
end
