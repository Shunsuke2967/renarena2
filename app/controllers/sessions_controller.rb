class SessionsController < ApplicationController
  skip_before_action :login_required
  # ログイン画面
  def new
  end

  # ログイン
  def create
    user = User.find_by(name: session_params[:name])

    if user&.authenticate(session_params[:password])
      session[:user_id] = user.id
      redirect_to root_path, notice: 'ログインしました'
    else
      redirect_to sessions_path, alert: ['ログインできませんでした']
    end
  end

  # ログアウト
  def destroy
  end

  private

  def session_params
    params.require(:session).permit(:name, :password)
  end
end
