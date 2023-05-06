module Users
  class UpdateUserService < BaseService
    def initialize(user, params)
      @user    = user
      @params  = params
    end

    def call
      user.update(params)
    end

    private

    attr_reader :user, :params
  end
end