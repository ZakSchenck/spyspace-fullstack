class CreateReplies < ActiveRecord::Migration[7.1]
  def change
    create_table :replies do |t|
      t.string :body
      t.references :post, null: false, foreign_key: true

      t.timestamps
    end
  end
end
