class AddCategoryToIssues < ActiveRecord::Migration[6.0]
  def change
    add_column :issues, :category, :string
  end
end
