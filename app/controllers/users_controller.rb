class UsersController < ApplicationController
  def show

     @user=User.find(params[:id])
     @books=@user.books
  end

  def index
    @user=current_user
    @users=User.all
  end

  def edit
     @user = User.find(params[:id])
     unless @user.id == current_user.id
      redirect_to user_path(current_user)
    end
  end

   def create
    @user = User.new(user_params)
    if @user.save
        flash[:notice] = "Welcome! You have signed up successfully.
"
    redirect_to books_index_path
    else
    render new_user_registration_path
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
        flash[:notice] = "You have updated user successfully."
    redirect_to user_path(@user.id)
    else
        render :edit
    end
  end
  private
   def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end
end
