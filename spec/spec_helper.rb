require "bundler/setup"
require "redex"

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = ".rspec_status"

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end

  config.before(:each) do
    Redex.secret_pv = nil
  	Redex.secret_token = nil
  	Redex.service_url = 'https://scommerce.userede.com.br/Redecard.Komerci.External.WcfKomerci/KomerciWcf.svc'
  end
end
