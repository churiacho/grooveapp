module Dashboard
    class UsersController < AdminController
        before_action :authenticate_admin, only: [:index, :new, :create_user]
        before_action :set_user, only: [:show, :edit]

        def index
            @users = User.all.order("created_at DESC")
            @users_with_index = User.all
        end

        def show
            @activities = current_user.activities.order("created_at DESC")
        end

        def edit
        end

        def new
            # Edit the devise notice...
            # already_authenticated: "Already signed in, or not authorized."
        end

        def create_user
            current_user = User.new(user_params)
            if current_user.save
                redirect_to dashboard_users_path, notice: 'New user successfully created'
            else
                redirect_to :back
                flash[:info] = "Something is wrong, try again."
            end
        end

 #       def update_profile_image
 #           @user = current_user
 #           if @user.update(user_params)
 #               # Sign in the user by passing validation in case their password changed
 #               bypass_sign_in(@user)
 #               redirect_to :back
 #               flash[:info] = "Your image has been saved"
 #           else
 #               render :edit, notice: "Image upload failed, please try again"
 #           end
 #       end

        def update_profile
            @user = current_user
            if @user.update(user_params)
                bypass_sign_in(@user)
                redirect_to :back, notice: "Your changes have been saved."
            else
                render :edit, alert: "Try again, something went wrong"
            end
        end

        def update_password
            @user = current_user
            if @user.update(user_params)
                bypass_sign_in(@user)
                redirect_to :back, notice: "Your password has been changed"
            else
                redirect_to :back, alert: "Password update failed, try again"
            end
        end

        def destroy
            @user = current_user
            if @user.destroy
                redirect_to root_path
            end
        end

        private

        def set_user
            @user = User.friendly.find(params[:id])
        end

        def user_params
            params.require(:user).permit(:password, :password_confirmation, :email, :first_name, :last_name, :about, :role, :img, :slug)
        end

    end
end