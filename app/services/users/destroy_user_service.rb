module Users
  class DestroyUserService < BaseService
    def initialize(user)
      @user = user
    end

    def call
      user.destroy
    end

    private

    attr_reader :user
  end
end