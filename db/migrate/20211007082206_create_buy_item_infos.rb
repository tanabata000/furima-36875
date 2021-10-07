class CreateBuyItemInfos < ActiveRecord::Migration[6.0]
  def change
    create_table :buy_item_infos do |t|
      t.references :item,   null: false, foreign_key: true
      t.references :user,   null: false, foreign_key: true
      t.timestamps
    end
  end
end
