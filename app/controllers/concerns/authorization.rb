module Authorization
  extend ActiveSupport::Concern

  included do
    include Pundit
  end
end
