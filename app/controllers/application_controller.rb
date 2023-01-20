class ApplicationController < ActionController::Base
  include ErrorHandler
  include Authentication
  include Pagy::Backend
  include Authorization

  rescue_from ActiveRecord::RecordNotFound, with: :not_found

  def not_found
    render(json: { error: 'not found' }, status: :not_found)
  end
end
