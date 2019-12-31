class CreateIssues < ActiveRecord::Migration[6.0]
  def change
    create_table :issues do |t|
      t.string :status
      t.datetime :closed_at

      t.timestamps
    end
  end
end
