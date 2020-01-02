class CreateIssues < ActiveRecord::Migration[6.0]
  def change
    create_table :issues do |t|
      t.string :title
      t.string :status
      t.datetime :closed_at
      t.references :project, null: false, foreign_key: true

      t.timestamps
    end
  end
end
