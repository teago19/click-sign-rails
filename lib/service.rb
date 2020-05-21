module ClickSign
	require 'rest-client'
	class Service

		class Response
			attr_reader :status, :body

			def initialize(**args)
				@status_code = args[:status_code]
				@body = JSON.parse(args[:body]) if args[:body].present?
			end

			def created?
				@status_code == 201
			end

			def success?
				@status_code == 200
			end

			def error?
				false
			end
		end

		class ErrorResponse < ClickSign::Service::Response
			attr_reader :errors

			def initialize(**args)
				super 
				@errors = @body['errors'] if @body.present?
			end

			def bad_request?
				@status_code == 400
			end

			def unauthorized?
				@status_code == 401
			end

			def forbiden?
				@status_code == 403
			end

			def not_found?
				@status_code == 404
			end

			def unprocessable_entity?
				@status_code == 422
			end

			def server_error?
				@status_code == 500
			end

			def error?
				true
			end
		end

		# <CLASS METHODS>
		def self.accept_header
			{ Accept: 'application/json' }
		end

		def self.content_type
			{ 'Content-Type': 'application/json'}
		end

		def self.api_url(*path)
			url = [ClickSign::Configuration.sandbox ? ClickSign::Configuration.sandbox_url : ClickSign::Configuration.url]
			url += ['api']
			url += [ClickSign::Configuration.api_version]
			url += path
			url.join("/") + "?access_token=#{ClickSign::Configuration.access_token}"
		end

		def self.get url: nil, payload: nil
			request method: :get, url: url, payload: payload
		end

		def self.post url: nil, payload: nil
			request method: :post, url: url, payload: payload
		end

		def self.patch url: nil, payload: nil
			request method: :patch, url: url, payload: payload
		end

		def self.delete url: nil, payload: nil
			request method: :delete, url: url, payload: payload
		end

		def self.request method: nil, url: nil, payload: nil
			begin
				response = RestClient::Request.execute(
					method: method,
					url: api_url(url),
					payload: payload,
					headers: accept_header,
					content_type: content_type
	      )
	      ClickSign::Service::Response.new(status_code: response.code, body: response.body)
	     rescue RestClient::ExceptionWithResponse => _e
	     	ClickSign::Servive::ErrorResponse.new(status_code: _e.response.code, body: _e.response.body)
	     rescue RestClient::ServerBrokeConnection => _e
	     	ap _e
	     rescue RestClient::SSLCertificateNotVerified => _e 
	     	ap _e
	     end
		end
		# </CLASS METHODS>

		# <INSTANCE METHODS>
		# </INSTANCE METHODS>
	end
end