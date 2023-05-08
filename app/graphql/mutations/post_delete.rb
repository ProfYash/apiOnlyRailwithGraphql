# frozen_string_literal: true

module Mutations
  class PostDelete < BaseMutation
    description "Deletes a post by ID"

    field :post, Types::PostType, null: false

    argument :id, ID, required: true

    def resolve(id:)
      post = ::Post.find(id)
      raise GraphQL::ExecutionError.new "Error deleting post", extensions: post.errors.to_hash unless post.destroy

      { post: post }
    end
  end
end
