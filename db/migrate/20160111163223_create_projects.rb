class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.string :name
      t.string :value_proposition
      t.decimal :project_goal
      t.text :description
      t.date    :expiration_date
      t.string :image
      t.string :video
      t.integer :status

      t.timestamps
    end
  end
end
