# frozen_string_literal: true

module Mutations
  class UserUpdate < BaseMutation
    description "Updates a user by id"

    field :user, Types::UserType, null: false
    field :errors, [String], null: true
    argument :id, ID, required: true
    argument :user_name, String, required: true
    argument :user_email, String, required: true

    def resolve(id:, user_name:, user_email:)
      user = User.find(id)
      if !user
        {
          user: nil,
          errors: ["No user Found"],
        }
      end
      if user.update(name: user_name, email: user_email)
        {
          user: user,
          errors: [],
        }
      else
        {
          user: user,
          errors: ["User Found but Unable to Update"],
        }
      end
    end
  end
end
