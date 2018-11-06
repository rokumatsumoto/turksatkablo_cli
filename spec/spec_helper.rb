

require 'simplecov'

SimpleCov.start do
  add_filter '/spec/'
end

require 'turksatkablo_cli/online_operations/helpers'
require 'turksatkablo_cli/online_operations/enums'
require 'turksatkablo_cli/online_operations/version'
require 'turksatkablo_cli'
require 'turksatkablo_cli/base'
require 'turksatkablo_cli/online_operations/agent'


module SpecHelper
end

RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.shared_context_metadata_behavior = :apply_to_host_groups
  config.include(SpecHelper)
  config.include(TurksatkabloCli::OnlineOperations::Helpers)

  config.before(:suite) do
  end

end
