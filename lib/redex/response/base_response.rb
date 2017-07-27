module Redex
	module Response
		class BaseResponse
			attr_reader :raw, :code, :message, :sequential_id, :transaction_id

			def initialize(raw_response)
				@raw = clear(raw_response)
			end

			def clear(httpi_result)
				httpi_result = Hash[httpi_result.map { |k, v| [k.to_sym, v] }]
				httpi_result.select! {|k,v| v != [{"i:nil"=>"true"}]}
				httpi_result.each { |k, v| httpi_result[k] = v.first }
			end

			def code
				@code ||= @raw[:CodRet].to_i
			end

			def message
				@message ||= @raw[:Msgret]
			end

			def sequential_id
				@sequential_id ||= @raw[:NumSqn].to_i
			end

			def transaction_id
				@transaction_id ||= @raw[:Tid].to_i
			end

			def datetime_sanitize(raw_date, raw_time)
				if raw_date && raw_time
					DateTime.strptime(raw_date + raw_time + '-03:00', '%Y%m%d%H:%M:%S%z')
				end
			end
		end
	end
end

require 'redex/response/transaction_response'
require 'redex/response/cancel_response'
require 'redex/response/query_response'
