class UsersController < ApplicationController
  skip_before_action :login_required

  # サインアップ画面
  def new
    @user = User.new
  end

  # ユーザー作成
  def create
    user = User.new(user_params)
    if user.save
      session[:user_id] = user.id
      redirect_to root_path
    else
      redirect_to new_users_path, alert: user.errors.full_messages
    end
  end

  # ユーザー削除
  def destroy
  end

  private

  def user_params
    params.require(:user).permit(:name, :password, :password_confirmation)
  end
end
