module ClickSign
	module Webhooks
		module Routes
		end
	end
end

module ActionDispatch::Routing
	class Mapper
		def click_sign_for 
			get 'test_click_sign', controller: :proposals, action: :teste
		end
	end
end