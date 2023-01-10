require 'rails_helper'

describe 'commentable' do
  with_model :WithCommentable do
    table do |t|
      t.bigint :user_id
      t.string :body
    end

    model do
      include Commentable
    end
  end
end
