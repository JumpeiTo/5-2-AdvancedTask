class BookCommentsController < ApplicationController
    def create
        @book = Book.find(params[:book_id])
        comment = current_user.book_comments.new(book_comment_params)
        comment.book = @book
        if comment.save
        else
            @book_comment = comment
            @bookf = Book.new
        end
    end
    
    def destroy
    BookComment.find(params[:id]).destroy
    end
    
    private
    
    def book_comment_params
        params.require(:book_comment).permit(:comment)
    end
    
    def book_params
    params.require(:book).permit(:title,:body)
  end
end
