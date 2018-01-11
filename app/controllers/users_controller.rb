class UsersController < ApplicationController
    before_action :set_user, only: [:edit, :update, :show]
    before_action :require_user, except: [:index, :show]
	before_action :require_same_user, only: [:edit, :update]
	
    def index
		@users = User.all
	end
    
    def new
       @user = User.new
    end
    
    def create
        @user = User.new(user_params)
        if @user.save then
           flash[:success] = "Welcome to Alphe Blog #{@user.username}!"
        else
           render 'new' 
        end
    end
    
    def edit
    end
    
    def update
        if @user.update(user_params) then
            flash[:success] = "Yout account was successfully updated"
            redirect_to articles_path
        else
           render 'edit' 
        end
    end
    
    def show
    end
    
    private
    def user_params
       params.require(:user).permit(:username, :email, :password)
    end
    
    def set_user
        @user = User.find(params[:id])
    end
    
    def require_same_user
       if current_user != @user then
            flash[:danger] = "You can only edit your own account"
			redirect_to root_path
        end
    end
end