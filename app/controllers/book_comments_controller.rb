class BookCommentsController < ApplicationController
  def create
    @bookid = Book.find(params[:book_id])
    comment = BookComment.new(book_comment_params)
    comment.user_id = current_user.id
    comment.book_id = @bookid.id
    comment.save
    @book_comment = BookComment.new
  end

  def destroy
    BookComment.find_by(params[:id], book_id: params[:book_id]).destroy
    @bookid = Book.find(params[:book_id])
    @book_comment = BookComment.new
  end

  private

  def book_comment_params
    params.require(:book_comment).permit(:comment)
  end
end
