class UsersController < ApplicationController
  before_action :is_matching_login_user, only: [:update, :edit]

  def show
    @user = User.find(params[:id])
    @books = Kaminari.paginate_array(@user.books).page(params[:page]).per(5) # ページネーション
    @book = Book.new
    @books2 = @user.books
    # 投稿数の記述
    @today_book =  @books2.created_today
    @yesterday_book = @books2.created_yesterday
    @this_week_book = @books2.created_this_week
    @last_week_book = @books2.created_last_week
    # DMの記述
    @currentUserEntry=Entry.where(user_id: current_user.id)
    @userEntry=Entry.where(user_id: @user.id)
    if @user.id == current_user.id
    else
      @currentUserEntry.each do |cu|
        @userEntry.each do |u|
          if cu.room_id == u.room_id then
            @isRoom = true
            @roomId = cu.room_id
          end
        end
      end
      if @isRoom
      else
        @room = Room.new
        @entry = Entry.new
      end
    end
  end
  
  def follower
    user = User.find(params[:id])
    @users = user.followings
  end
  
  def followerd
    user = User.find(params[:id])
    @users = user.followers
  end

  def index
    @users = User.all
    @book = Book.new
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to user_path(@user), notice: "You have updated user successfully."
    else
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end

  def is_matching_login_user
    user = User.find(params[:id])
    unless user.id == current_user.id
      redirect_to user_path(current_user)
    end
  end
end
