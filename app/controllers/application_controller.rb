class ApplicationController < ActionController::Base
  def after_sign_in_path_for(resource)
    if resource.admin?  # Check if the logged-in user is an admin
      admin_users_path  # Redirect admin to the admin users index page
    else
      super  # Default redirection for non-admin users (typically the root path or user dashboard)
    end
  end
end
