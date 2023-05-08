# frozen_string_literal: true

module Mutations
  class PostUpdate < BaseMutation
    description "Updates a post by id"

    field :post, Types::PostType, null: false
    field :errors, [String], null: true
    argument :id, ID, required: true
    argument :body, String, required: true
    argument :title, String, required: true

    def resolve(id:, body:, title:)
      if id != "" && body != "" && title != ""
        post = Post.find(id)
        if !post
          {
            post: nil,
            errors: ["No post Found"],
          }
        end
        if post.update(body: body, title: title)
          {
            post: post,
            errors: [],
          }
        else
          {
            post: post,
            errors: ["Post Found but Unable to Update"],
          }
        end
      else
        {
          post: nil,
          errors: ["Some Parameters not sent"],
        }
      end
    end
  end
end
