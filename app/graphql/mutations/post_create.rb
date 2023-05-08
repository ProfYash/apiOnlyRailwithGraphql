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
        { errors: "Couldn't find user" }
      end
      post = user.posts.build(body: body, title: title)
      if post.save
        { post: post }
      else
        { errors: post.errors.full_messages.join(", ") }
      end
    end
  end
end
