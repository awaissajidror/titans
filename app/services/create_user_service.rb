class CreateUserService < BaseService
  def initialize(name, email, password, phone_number, role)
    @name         = name
    @role         = role
    @email        = email
    @password     = password
    @phone_number = phone_number
  end

  def call
    user = User.new(name: name, email: email, password: password, phone_number: phone_number, role: role)
    return user if user.save

    raise StandardError.new("Failed to create user: #{user.errors.full_messages.to_sentence}")
  end

  private

  attr_reader :name, :email, :password, :phone_number, :role
end