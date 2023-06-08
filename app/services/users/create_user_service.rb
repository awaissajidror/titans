module Users
  class CreateUserService < BaseService
    def initialize(params)
      @params = params
    end

    def call
      user          = User.new(params)
      user.role     = 4 if params[:role].present? && params[:role] == 'Office worker'
      user.email    = Faker::Internet.email
      user.password = Faker::Internet.password(min_length: 6)

      user.save
    end

    private

    attr_reader :params
  end
end