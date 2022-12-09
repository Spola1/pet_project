class Api::V1::ApplicationController < Api::ApplicationController
  before_action :doorkeeper_authorize!
  
  def build_meta(collection)
    {
      count: collection.count,
    }
  end

  def self.responder
    JsonResponder
  end

  private

  def current_resource_owner
    @current_resource_owner ||= User.find(doorkeeper_token.resource_owner_id) if doorkeeper_token
  end
end
