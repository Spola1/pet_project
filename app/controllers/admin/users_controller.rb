module Admin
  class UsersController < BaseController
    before_action :require_authentication
    before_action :set_user, only: [:edit, :update, :destroy, :ban]
    before_action :authorize_user!
    after_action :verify_authorized

    def index
      respond_to do |format|
        format.html do
          @pagy, @users = pagy(User.all.left_outer_joins(:questions).distinct.select('users.*, COUNT(questions.*)
            AS questions_count').group('users.id'))
        end

        format.zip { respond_with_zipped_users }
      end
    end

    def create
      if params[:archive].present?
        UserBulkService.call(params[:archive])
        flash[:success] = 'Users imported!'
      end

      redirect_to(admin_users_path)
    end

    def edit; end

    def update
      if @user.update(user_params)
        flash[:success] = 'User updated!'
        redirect_to(admin_users_path)
      else
        render(:edit)
      end
    end

    def destroy
      @user.destroy
      flash[:success] = 'User deleted!'
      redirect_to(admin_users_path)
    end

    def ban
      @user.toggle!(:banned)

      redirect_to(admin_users_path)
    end

    private

    def respond_with_zipped_users
      compressed_filestream = Zip::OutputStream.write_buffer do |zos|
        User.order(created_at: :desc).each do |user|
          zos.put_next_entry("user_#{user.id}.xlsx")
          zos.print(render_to_string(
                      layout: false, handlers: [:axlsx], formats: [:xlsx], template: 'admin/users/user', locals: { user: user },
                    ))
        end
      end

      compressed_filestream.rewind
      send_data(compressed_filestream.read, filename: 'users.zip')
    end

    def set_user
      @user = User.find(params[:id])
    end

    def authorize_user!
      authorize(@user || User)
    end

    def user_params
      params.require(:user).permit(:email, :name, :nickname, :password,
                                   :password_confirmation, :role)
    end
  end
end
