class BooksController < ApplicationController
  before_action :authenticate_user!
  
  def top
  end
  
  def index
    @books = Book.all
    @book = Book.new
  end
  
  def create
    # １.&2. データを受け取り新規登録するためのインスタンス作成
    @book = Book.new(book_params)
    @books = Book.all
    @book.user_id = current_user.id
    #本を投稿した人→特定
    # 3. データをデータベースに保存するためのsaveメソッド実行
    if @book.save
      redirect_to book_path(@book), notice: "You have created book successfully."
    else
      @books = Book.all
      render :index
    end
  end
  
  def show
    @book = Book.find(params[:id])
    #ユーザー情報も取得
  end
  
  def edit
    @book = Book.find(params[:id])
    if @book.user == current_user
      render :edit
    else
      redirect_to books_path
    end
  end

  def destroy
    book = Book.find(params[:id])  # データ（レコード）を1件取得
    book.destroy  # データ（レコード）を削除
    redirect_to books_path  # 投稿一覧画面へリダイレクト 
  end
  
  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      flash[:notice] ="You have updated book successfully."
      redirect_to book_path(@book)
    else
      render :edit
    end
  end
  
  private
  def book_params
    params.require(:book).permit(:title, :body)
  end
  

end
