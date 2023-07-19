class Users::SessionsController < Devise::SessionsController
    def new_guest
      user = User.guest
      sign_in user
      flash[:notice] = 'Signed in successfully as a guest.'
      redirect_to root_path
    end
  
    def new_admin
      user = User.admin
      sign_in user
      flash[:notice] = 'Signed in successfully as an admin.'
      redirect_to root_path
    end
end