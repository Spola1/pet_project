class Api::V1::ApplicationController < Api::ApplicationController
  def build_meta(collection)
    {
      count: collection.count,
    }
  end

  def self.responder
    JsonResponder
  end
end
