class Api::ApplicationController < ApplicationController
  skip_before_action :verify_authenticity_token
  include Authentication
  helper_method :current_user
  respond_to :json
end
