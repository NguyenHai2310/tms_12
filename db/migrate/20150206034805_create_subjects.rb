class CreateSubjects < ActiveRecord::Migration
  def change
    create_table :subjects do |t|
      t.string :name
      t.string :content
      t.datetime :start_at
      t.datetime :finish_at

      t.timestamps null: false
    end
  end
end