class CreateUserService < BaseService
  def initialize(email, password)
    @email    = email
    @password = password
  end

  def call
    user = User.new(email: email, password: password)
    return user if user.save

    raise StandardError.new("Failed to create user: #{user.errors.full_messages.to_sentence}")
  end

  private

  attr_reader :email, :password
end