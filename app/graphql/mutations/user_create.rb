# frozen_string_literal: true

module Mutations
  class UserCreate < BaseMutation
    description "Creates a new user"

    field :user, Types::UserType, null: false
    field :errors, [String], null: true
    argument :name, String, required: false
    argument :email, String, required: false

    def resolve(name:, email:)
      user = User.new(name: name, email: email)
      if user.save
        {
          user: user,
          errors: [],
        }
      else
        {
          # user: nil,
          errors: ["Something is Wrong"],
        }
      end

      # raise GraphQL::ExecutionError.new "Error creating user", extensions: user.errors.to_hash unless user.save

      # { user: user }
    end
  end
end
