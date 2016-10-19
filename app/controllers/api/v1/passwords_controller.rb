module Api
  module V1
    class PasswordsController < ApplicationController # Api::BaseController
      http_basic_authenticate_with name: "admin", password: ENV["API_SECRET"]
      skip_before_filter  :verify_authenticity_token

      def index
        # @passwords = Password.all.limit(100)
        @passwords = Password.joins(:user).select('users.email, passwords.username, passwords.password').where("vendor_id = ?", params['vendor_id'])
        #
        # find(:all,
        #   :join => [:user],
        #   :select => "user.email as email, password.username as username, password.password as password",
        #   :conditions => {:password => {:vendor_id => ]} }
        #   )
        respond_to do |format|
          format.json { render json: @passwords }
        end
      end

      def show
        password = Password.find(params[:id])
        respond_to do |format|
          format.json { render json: password}
        end
      end

      def import
        respond = Password.import(params['vendor_id'],params['email'],params['username'],params['pass'])
        respond_to do |format|
          format.json { render json: respond }
        end
      end

    end
  end
end
