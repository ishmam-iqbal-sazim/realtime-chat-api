class CreateDirectMessages < ActiveRecord::Migration[7.1]
  def change
    create_table :direct_messages do |t|
      t.text :content
      t.references :sender, foreign_key: { to_table: :users, on_delete: :cascade}, null: false
      t.references :receiver, foreign_key: { to_table: :users, on_delete: :cascade }, null: false

      t.timestamps
    end
  end
end
