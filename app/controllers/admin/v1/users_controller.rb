module Admin::V1
  class UsersController < ApiController
    def index
      @users = User.where.not(id: @current_user.id)
    end

    def create
      @user = User.new
      @user.attributes = user_params
      save_user!
    end

    private

    def user_params
      return {} unless params.has_key?(:user)
      params.require(:user).permit(:id, :name, :email, :password, :password_confirmation, :profile)
    end

    def save_user!
      @user.save!
      render :show
    rescue
      render_error(fields: @user.errors.messages)
    end
  end
end
