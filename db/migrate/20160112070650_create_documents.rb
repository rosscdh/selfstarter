class CreateDocuments < ActiveRecord::Migration
  def change
    create_table :documents do |t|
      t.string :name
      t.string :document
      t.integer :version
      t.integer :project_id
      t.integer :status

      t.timestamps
    end
  end
end
