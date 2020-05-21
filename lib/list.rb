module ClickSign
	class List

		attr_reader :key, :request_signature_key, :document_key, :signer_key, :sign_as, :created_at, :updated_at, :url, :group, :raw_data

		def initialize(args)
			@raw_data = args
			@key = args['key'] if args['key'].present?
			@request_signature_key = args['request_signature_key'] if args['request_signature_key'].present?
			@document_key = args['document_key'] if args['document_key'].present?
			@signer_key = args['signer_key'] if args['signer_key'].present?
			@sign_as = args['sign_as'] if args['sign_as'].present?
			@created_at = args['created_at'] if args['created_at'].present?
			@updated_at = args['updated_at'] if args['updated_at'].present?
			@url = args['url'] if args['url'].present?
			@group = args['group'] if args['group'].present?
		end

		# <CLASS METHODS>
		def self.create(**args)
			payload = build_payload(args)
			response = ClickSign::Service.post(
				url: 'lists',
				payload: payload
	   	)
	   	if response.created?
	   		new_signer = ClickSign::List.new(response.body['list'])
	   	end
		end

		def self.delete! list_key: nil
			response = ClickSign::Service.delete(
				url: ['lists', list_key]
      )
      if response.success?
      	ap 'removido'
      end
		end

		def self.build_payload(**args)
			payload = {}
			payload['document_key'] = args['document_key'] if args['document_key'].present?
			payload['signer_key'] = args['signer_key'] if args['signer_key'].present?
			payload['sign_as'] = args['sign_as'] if args['sign_as'].present?
			payload['group'] = args['group'] if args['group'].present?

			{ list: payload }
		end
		# </CLASS METHODS>

		# <INSTANCE METHODS>
		def delete!
			ClickSign::List.delete! self.key
		end
		# </INSTANCE METHODS>

	end
end