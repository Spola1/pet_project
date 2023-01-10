class Api::ApplicationController < ApplicationController
  include Authentication
  helper_method :current_user
  respond_to :json
end
