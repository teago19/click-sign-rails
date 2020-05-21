module ClickSign
	require 'click_sign/configuration'
	require 'click_sign/constants'
	require 'click_sign/service'
	require 'click_sign/document'
	require 'click_sign/signer'
	require 'click_sign/list'


	def self.configure(&block)
		yield ClickSign::Configuration
	end

end