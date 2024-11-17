class BooksController < ApplicationController
   before_action :correct_user, only: [:edit, :update]

  def create
    @books=Book.all
    @user=current_user
    @book = Book.new(book_params)
    @book.user = current_user
    if @book.save
       flash[:notice] = "You have created book successfully."
    redirect_to book_path(@book.id)
   else
     render :index
   end
  end

  def index
    @user=current_user
    @book=Book.new
    @books=Book.all
    @book.user=@user
  end

  def show
   @book=Book.find(params[:id])
   @user=@book.user
  end
  def destroy
    book = Book.find(params[:id])  # データ（レコード）を1件取得
    book.destroy  # データ（レコード）を削除
    redirect_to books_path  # 投稿一覧画面へリダイレクト
  end
  def edit
    @book=Book.find(params[:id])
    @user=@book.user
    unless @user.id == current_user.id
      redirect_to book_path(current_user)
    end
  end
  def update
    @book=Book.find(params[:id])
    if @book.update(book_params)
      flash[:notice] = "You have updated book successfully.
"
    redirect_to book_path(@book.id)
  else
    render :edit
  end
  end
private

  def book_params
    params.require(:book).permit(:title, :body)
  end
  def correct_user
    @book = Book.find(params[:id])
    @user = @book.user
    redirect_to(books_path) unless @user == current_user
  end

end
