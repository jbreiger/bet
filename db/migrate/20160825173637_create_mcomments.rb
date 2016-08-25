class CreateMcomments < ActiveRecord::Migration
  def change
    create_table :mcomments do |t|
      t.references :bet, index: true
      t.references :user, index: true
      t.text :comment

      t.timestamps
    end
  end
end
