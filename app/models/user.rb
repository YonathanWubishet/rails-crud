# frozen_string_literal: true

# Internal: Validates User attributes
class User
  include ActiveModel::Model
  attr_accessor :id, :first_name, :last_name, :email, :avatar

  # Internal: Finds user
  def self.find(_id)
    response = Faraday.get 'https://reqres.in/api/users/2'
    response.body
  end
end
