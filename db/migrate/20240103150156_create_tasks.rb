class CreateTasks < ActiveRecord::Migration[7.1]
  def change
    create_table :tasks do |t|
      t.string :description
      t.boolean :done
      t.belongs_to :project, null: false, foreign_key: true

      t.timestamps
    end
  end
end
