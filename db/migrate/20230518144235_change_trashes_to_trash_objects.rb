class ChangeTrashesToTrashObjects < ActiveRecord::Migration[6.1]
  def change
    rename_table :books_comments, :book_comments
  end
end
