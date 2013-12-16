class ChangeDateFormatInFctPackHistories < ActiveRecord::Migration
  def change
    change_column :fct_pack_histories, :processed_at, :datetime
    change_column :fct_pack_histories, :completed_at, :datetime
  end
end
