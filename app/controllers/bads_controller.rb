class BadsController < ApplicationController
  def create
    book = Book.find(params[:book_id])
    bad = current_user.bads.new(book_id: book.id)
    bad.save
    redirect_to book_path(book)
  end

  def destroy
    book = Book.find(params[:book_id])
    bad = current_user.bads.find_by(book_id: book.id)
    bad.destroy
    redirect_to book_path(book)
  end
end
