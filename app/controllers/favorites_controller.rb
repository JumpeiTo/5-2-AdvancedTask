class FavoritesController < ApplicationController
    def create
        book = Book.find(params[:book_id])
        favorite = current_user.favorites.new(book_id: book.id)
        if favorite.save
            # request.refererを使用して直前のURLを取得し、そのURLがbook_path(book)と一致するかどうかをチェック
            if request.referer == book_url(book)
              redirect_to book_path(book)
            else
              redirect_to books_path
            end
        else
          redirect_to book_path(book)
        end
    end
    
    def destroy
        book = Book.find(params[:book_id])
        favorite = current_user.favorites.find_by(book_id: book.id)
        if favorite.destroy
          if request.referer == book_url(book)
            redirect_to book_path(book)
          else
            redirect_to books_path
          end
        else
          redirect_to book_path(book)
        end
    end
end
