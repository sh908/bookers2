class UsersController < ApplicationController
  before_action :authenticate_user!
 before_action :correct_user, only:[:edit ]

 def show
  @user=User.find(params[:id])
  @books = @user.books.page(params[:page]).reverse_order
  @book= Book.new
 end

 def edit
 @user=User.find(params[:id])
 end

 def index
  @users=User.all
  @book=Book.new
  @user=current_user
 end

 def update
   @user=User.find(params[:id])
  if @user.update(user_params)
     flash[:success] = "successfully"
     redirect_to user_path(@user)
  else

     render :edit
  end
 end

 private
  def user_params
    params.require(:user).permit(:name, :profile_image, :introduction)
  end

  def correct_user
       @user = User.find(params[:id])
    if @user.id != current_user.id
       redirect_to user_path(current_user.id)
    end
  end
end
