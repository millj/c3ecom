class CreateFctPackHistories < ActiveRecord::Migration
  def change
    create_table :fct_pack_histories do |t|
      t.string :order_num
      t.string :user_name
      t.date :processed_at
      t.date :completed_at

      t.timestamps
    end
  end
end
