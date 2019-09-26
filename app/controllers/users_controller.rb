class UsersController < ApplicationController

  def index
    @users = User.all
    @fields = User.new.attributes.keys
  end
end
