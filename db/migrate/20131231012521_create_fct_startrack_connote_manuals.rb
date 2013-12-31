class CreateFctStartrackConnoteManuals < ActiveRecord::Migration
  def change
    create_table :fct_startrack_connote_manuals do |t|
      t.string :order_no
      t.string :connote
      t.string :despatch_date
      t.string :name1
      t.string :name2
      t.string :addr1

      t.timestamps
    end
  end
end
