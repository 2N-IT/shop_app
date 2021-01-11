module Admin
  class BaseController < ApplicationController
    class AuthorizationError < StandardError; end
    layout 'admin'
    before_action :authorize_admin!

    rescue_from AuthorizationError do |e|
      flash[:error] = e.message
      redirect_to root_path
    end

    private

    def authorize_admin!
      return if current_user.present? && current_user.admin

      raise AuthorizationError, 'You are not permitted to access this page or it does not exist'
    end
  end
end
