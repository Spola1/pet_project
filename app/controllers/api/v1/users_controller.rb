class Api::V1::UsersController < Api::V1::ApplicationController
  def me
    render(json: current_resource_owner)
  end

  def show
    @user = User.find(params[:id])

    render(json: @user)
  end

  def index
    users = User.all

    respond_with(users, each_serializer: UserSerializer, meta: build_meta(users))
  end
end

# konata.to_json(:include => { :posts => {:include => { :comments => {:only => :body } }, :only => :title } })

# user.to_json(:include => { :answers => {:include => { :qs => {:only => :name } }, :only => :body } })
