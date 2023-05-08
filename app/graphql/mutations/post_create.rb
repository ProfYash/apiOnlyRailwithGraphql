# frozen_string_literal: true

module Mutations
  class PostCreate < BaseMutation
    description "Creates a new post"

    field :post, Types::PostType
    field :errors, String
    argument :user_id, ID, required: true
    argument :body, String, required: true
    argument :title, String, required: true

    def resolve(body:, title:, user_id:)
      user = User.find(user_id)
      if !user
        { error: "Couldnt create post" }
      end
      if user.posts.create(body: body, title: title)
        { post: post }
      else
        { error: "Couldnt create post" }
      end
    end
  end
end
