class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.string :slug
      t.string :name
      t.string :value_proposition
      t.decimal :project_goal
      t.text :description
      t.string :payment_description
      t.date    :expiration_date
      t.string :image
      t.string :video
      t.integer :status

      t.timestamps
    end
    add_index :projects, :slug, :unique => true
  end
end
