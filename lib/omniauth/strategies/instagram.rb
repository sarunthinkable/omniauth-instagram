require 'omniauth-oauth2'

module OmniAuth
  module Strategies
    class Instagram < OmniAuth::Strategies::OAuth2
      option :client_options,         site: 'https://api.instagram.com',
                                      authorize_url: 'https://api.instagram.com/oauth/authorize',
                                      token_url: 'https://api.instagram.com/oauth/access_token'

      option :redirect_url

      uid { access_token.params['user_id'] }

      def authorize_params
        super.tap do |params|
          params[:response_type] = 'code'
          params[:client_id] = client.id
          params[:redirect_uri] ||= callback_url
        end
      end

      def callback_url
        options.redirect_url || full_host + script_name + callback_path
      end
    end
  end
end
