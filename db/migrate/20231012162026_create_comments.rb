class CreateComments < ActiveRecord::Migration[7.0]
  def change
    create_table :comments do |t|
      t.text :comment
      t.bigint :post_id, index: true, null: false
      t.bigint :user_id, index:true, null:false
      t.timestamps
    end
  end
end
