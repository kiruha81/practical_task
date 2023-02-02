class FavoritesController < ApplicationController
  def create
    @bookid = Book.find(params[:book_id])
    favorite = current_user.favorites.new(book_id: @bookid.id)
    favorite.save
  end

  def destroy
    @bookid = Book.find(params[:book_id])
    favorite = current_user.favorites.find_by(book_id: @bookid.id)
    favorite.destroy
  end
end
