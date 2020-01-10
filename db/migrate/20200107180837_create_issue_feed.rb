class CreateIssueFeed < ActiveRecord::Migration[6.0]
  def change
    create_table :issue_feeds do |t|
      t.references :issue, null: false, foreign_key: true
      t.references :feed, polymorphic: true, index: true
      
      t.timestamps
    end
  end
end
