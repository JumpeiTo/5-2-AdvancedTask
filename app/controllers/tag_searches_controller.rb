class TagSearchesController < ApplicationController
  def search
  @range = params[:range]
  @word = params[:word]
  @books = Book.where(tag: @word)
  render "searches/search"
  end
end
