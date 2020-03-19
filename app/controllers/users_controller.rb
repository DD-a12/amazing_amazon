class UsersController < ApplicationController
    def new
        @user = User.new
    end
    def create
        @user = User.new user_params
        if @user.save
            session[:user_id] = @user.id
            redirect_to root_path
        else
            render :new
        end
    end
    def edit
        find_params
    end
    def update
        find_params
        if @user.update user_params
            redirect_to root_path
        else
            render :edit
        end
    end
    def update_password
        if @user&.authenticate params[:current_password]
            user_params[:password] = params[:id][:new_password] 
            if @user.update user_params
                redirect_to root_path
            else
                render :edit_password
            end
        else
            render :edit_password, alert: "Current password has to be matched"
        end
    end
    def edit_password
        find_params
    end
    def admin_panel
        if current_user.is_admin?
        end
    end
    private
    
    def find_params
        @user = User.find params[:id]
    end

    def user_params
        params.require(:user).permit(
            :first_name, :last_name, :email, :password, :password_confirmation)
    end
end
