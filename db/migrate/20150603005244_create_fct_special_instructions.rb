class CreateFctSpecialInstructions < ActiveRecord::Migration
  def change
    create_table :fct_special_instructions do |t|
      t.string :order_number
      t.integer :priority
      t.string :delivery_instructions
      t.string :sscc

      t.timestamps
    end
  end
end
