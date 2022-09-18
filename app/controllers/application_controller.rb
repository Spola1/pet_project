class ApplicationController < ActionController::Base
  include ErrorHandler
  include Authentication
end
