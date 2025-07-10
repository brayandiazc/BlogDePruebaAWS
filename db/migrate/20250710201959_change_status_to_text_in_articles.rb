class ChangeStatusToTextInArticles < ActiveRecord::Migration[8.0]
  def change
    change_column :articles, :status, :string
  end
end
