module ClickSign
	class Document
		require "base64"

		attr_reader :key, :path, :filename, :uploaded_at, :updated_at, :finished_at, :deadline_at, :status, :auto_close, :locale, :metadata, :sequence_enabled, :signable_group, :remind_interval, :raw_data, :original_file_url

		def initialize(args)
			@raw_data = args
			@key = args['key'] if args['key'].present?
			@path = args['path'] if args['path'].present?
			@filename = args['filename'] if args['filename'].present?
			@uploaded_at = args['uploaded_at'] if args['uploaded_at'].present?
			@updated_at = args['updated_at'] if args['updated_at'].present?
			@finished_at = args['finished_at'] if args['finished_at'].present?
			@deadline_at = args['deadline_at'] if args['deadline_at'].present?
			@status = args['status'] if args['status'].present?
			@auto_close = args['auto_close'] if args['auto_close'].present?
			@locale = args['locale'] if args['locale'].present?
			@metadata = args['metadata'] if args['metadata'].present?
			@sequence_enabled = args['sequence_enabled'] if args['sequence_enabled'].present?
			@signable_group = args['signable_group'] if args['signable_group'].present?
			@remind_interval = args['remind_interval'] if args['remind_interval'].present?
			@original_file_url = args['downloads']['original_file_url'] if args['downloads'].present?
		end

		# <CLASS METHODS>
		def self.create(**args)
			payload = build_payload(args)
			response = ClickSign::Service.post(
			 	url: 'documents',
			 	payload: payload
		 	)
      if response.created?
      	return ClickSign::Document.new(response.body['document'])
      end
		end

		def self.find document_key: nil
			response = ClickSign::Service.get(
				url: ['documents', document_key]
			)
			if response.success?
				return ClickSign::Document.new(response.body['document'])
			end
		end

		def self.configure(**args)
			document_key = args.delete(:document_key)
			payload = build_payload args 
			response = ClickSign::Service.patch(
				url: ['documents', document_key],
				payload: payload
      )
      if response.success?
      	return ClickSign::Document.new(response.body['document'])
      end
		end

		def self.finish! document_key: nil
			response = ClickSign::Service.patch(
				url: ['documents', document_key, 'finish'],
      )
      if response.success?
      	return ClickSign::Document.new(response.body['document'])
      end
		end

		def self.cancel! document_key: nil
			response = ClickSign::Service.patch(
				url: ['documents', document_key, 'cancel'],
      )
      if response.success?
      	return ClickSign::Document.new(response.body['document'])
      end
		end

		def self.duplicate! document_key: nil
			response = ClickSign::Service.post(
				url: ['documents', document_key, 'duplicate'],
      )
      if response.created?
      	return ClickSign::Document.new(response.body['document'])
      end
		end

		def self.delete! document_key: nil 
			response = ClickSign::Service.delete(
				url: ['documents', document_key],
      )
      if response.success?
      	true
      else
      	false
      end
		end

		def self.build_payload(**args)
			payload = {}

			if args[:file].present?
				data_type = File.extname(args[:file]).gsub('.','')
				payload['content_base64'] = "data:application/#{data_type};base64,#{Base64.encode64(args[:file].read)}"
			end 

			payload['path'] = "/#{args[:name]}" if args[:name].present?
			payload['deadline_at'] = args[:deadline_at] if args[:deadline_at].present?
			payload['auto_close'] = args[:auto_close] if args[:auto_close].present?
			payload['locale'] = args[:locale] if args[:locale].present?
			payload['sequence_enabled'] = args[:sequence_enabled] if args[:sequence_enabled].present?
			payload['remind_interval'] = args[:remind_interval] if args[:remind_interval].present?

			{document: payload}
		end
		# </CLASS METHODS>

		# <INSTANCE METHODS>
		def add_signer signer_key: nil, sign_as: nil, group: nil
			ClickSign::List.create document_key: self.key, signer_key: signer_key, sign_as: sign_as, group: nil
		end

		def remove_signer list_key: nil
			ClickSign::List.delete list_key: list_key
		end

		def edit deadline_at: nil, auto_close: nil, locale: nil, sequence_enabled: nil, remind_interval: nil
			ClickSign::Document.configure( 
      	document_key: self.key, 
      	deadline_at: deadline_at, 
      	auto_close: auto_close, 
      	locale: locale, 
      	sequence_enabled: sequence_enabled, 
      	remind_interval: remind_interval
    	).attributes
		end
		
		def finish!
			ClickSign::Document.finish! document_key: self.key
		end

		def cancel!
			ClickSign::Document.cancel! document_key: self.key
		end

		def duplicate!
			ClickSign::Document.duplicate! document_key: self.key
		end

		def delete!
			ClickSign::Document.delete! document_key: self.key
		end
		# </INSTANCE METHODS>
	end
end