class UsersController < ApplicationController
    # to show all users 
    def index
      @users = User.all
    end



end