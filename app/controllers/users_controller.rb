class UsersController < ApplicationController
    skip_before_action :login_required, only: %i[new, create]
    before_action :set_user, only: %i[ show edit update destroy ]
    def new
        @user = User.new
    end
    def index
        @users = User.all
    end

    def create
        @user = User.new(user_params)
        if @user.save
            redirect_to user_path(@user.id)
        else
            render :new
        end
    end
    def update
        if @user.update(user_params)
          redirect_to user_path
        else
          render :edit
        end
    end

    def show
        @user = User.find(params[:id])
    end
    def edit
    end

    def destroy
        @user.destroy
        respond_to do |format|
          format.html { redirect_to users_url, notice: "削除しました。" }
          format.json { head :no_content }
        end
    end

    private
    def set_user
        @user = User.find(params[:id])
    end

    def user_params
        params.require(:user).permit(:name, :email, :password,:password_confirmation,:image, :image_cache)
    end
end