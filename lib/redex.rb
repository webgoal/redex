require "redex/version"
require "redex/request/base_request"
require "redex/response/base_response"
require "helpers/configuration"

module Redex
	extend Configuration

	define_setting :secret_pv
	define_setting :secret_token
end
