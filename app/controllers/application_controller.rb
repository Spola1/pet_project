class ApplicationController < ActionController::Base
  include ErrorHandler
  include Authentication
  include Pagy::Backend
  include Authorization
end
