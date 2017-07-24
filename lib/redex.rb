require "redex/version"
require "helpers/configuration"

module Redex
	extend Configuration

	define_setting :secret_pv
	define_setting :secret_token
end
