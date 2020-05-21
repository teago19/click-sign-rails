module ClickSign
	class Configuration
		@base_env = "CLICK_SIGN"
		@url_env = "#{@base_env}_URL"
		@sandbox_url_env = "#{@base_env}_SANDBOX_URL"
		@api_version_env = "#{@base_env}_API_VERSION"
		@access_token_env = "#{@base_env}_ACCESS_TOKEN"

		@access_token = ENV[@access_token_env]
		@url = ENV[@url_env] || 'https://app.clicksign.com'
		@sandbox_url = ENV[@sandbox_url_env] || 'https://sandbox.clicksign.com'
		@api_version = ENV[@api_version_env] || 'v1'

		@sandbox = false

		class << self 
			attr_accessor :base_env, :url_env, :sandbox_url_env, :api_version_env, :access_token_env, :access_token, :url, :sandbox_url, :api_version, :sandbox
		end
	end
end