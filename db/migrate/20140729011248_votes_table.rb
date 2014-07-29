class VotesTable < ActiveRecord::Migration
  def change
    create_table :votes do |t|
      t.references :user
      t.references :voteable, polymorphic: true
      t.column :value, :smallint

      t.timestamps
    end
  end
end
