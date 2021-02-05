class CreateTasks < ActiveRecord::Migration[5.2]
  def change
    create_table :tasks do |t|
      t.string :title, null: false
      t.text :content
      t.boolean :is_done, default: false, null: false

      t.timestamps
    end
  end
end
