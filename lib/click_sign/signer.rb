module ClickSign
	class Signer

		attr_reader :key, :email, :auths, :name, :documentation, :birthday, :phone_number, :has_documentation, :created_at, :updated_at, :raw_data

		def initialize(args)
			@raw_data = args
			@key = clean_key(args['key']) if args['key'].present?
			@email = clean_email(args['email']) if args['email'].present?
			@auths = clean_auths(args['auths']) if args['auths'].present?
			@name = clean_name(args['name']) if args['name'].present?
			@documentation = clean_documentation(args['documentation']) if args['documentation'].present?
			@birthday = clean_birthday(args['birthday']) if args['birthday'].present?
			@phone_number = clean_phone_number(args['phone_number']) if args['phone_number'].present?
			@has_documentation = clean_has_documentation(args['has_documentation']) if args['has_documentation'].present?
			@created_at = clean_created_at(args['created_at']) if args['created_at'].present?
			@updated_at = clean_updated_at(args['updated_at']) if args['updated_at'].present?
		end

		# <CLASS METHODS>
		def self.build_payload(**args)
			payload = {}

			payload['email'] = parse_email(args['email']) if args['email'].present?
	    payload['phone_number'] = parse_phone_number(args['phone_number']) if args['phone_number'].present?
	    payload['name'] = parse_name(args['name']) if args['name'].present?
	    payload['documentation'] = parse_documentation(args['documentation']) if args['documentation'].present?
	    payload['birthday'] = parse_birthday(args['birthday']) if args['birthday'].present?
	    payload['has_documentation'] = args['has_documentation'].present? ? parse_has_documentation(args['has_documentation']) : default_has_documentation 
	    payload['auths'] = args['auths'].present? ? parse_auths(args['auths']) : default_auths
	    payload['delivery'] = args['delivery'].present? ? parse_delivery(args['delivery']) : default_delivery

	    {signer: payload}
		end

		def self.default_delivery
			ClickSign::Constants::Delivery::EMAIL
		end

		def self.default_has_documentation
			true
		end

		def self.default_auths
			['email']
		end

		def self.create(**args)
			payload = build_payload(args)
			response = ClickSign::Service.post(
				url: 'signers',
				payload: payload
	   	)
	   	if response.created?
	   		new_signer = ClickSign::Signer.new(response.body['signer'])
	   	end
		end

		def self.find(signer_key: nil)
			response = ClickSign::Service.get(
				url: ['signers', signer_key]
      )
      if response.success?
      	signer = ClickSign::Signer.new(response.body['signer'])
      end
    end
		# </CLASS METHODS>

		# <INSTANCE METHODS>
    def add_to_document document_key: nil, sign_as: nil, group: nil
    	ClickSign::List.create document_key: document_key, signer_key: self.key, sign_as: sign_as, group: group
    end

    def remove_from_document list_key: nil
    	ClickSign::List.delete list_key: list_key
    end

    private
		def clean_key value
			value
		end

		def clean_email value
			value
		end

		def clean_auths value
			value
		end

		def clean_name value
			value
		end

		def clean_documentation value
			value
		end

		def clean_birthday value
			value
		end

		def clean_phone_number value
			value
		end

		def clean_has_documentation value
			value
		end

		def clean_created_at value
			value
		end

		def clean_updated_at value
			value
		end

		def parse_key value
			value
		end

		def parse_email value
			value
		end

		def parse_auths value
			value
		end

		def parse_name value
			value
		end

		def parse_documentation value
			value
		end

		def parse_birthday value
			value
		end

		def parse_phone_number value
			value
		end

		def parse_has_documentation value
			value
		end

		def parse_created_at value
			value
		end

		def parse_updated_at value
			value
		end


		# </INSTANCE METHODS>

	end
end