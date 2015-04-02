$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))


require 'rspec'
require 'ostruct'
require 'salt-lint'
require 'aruba/rspec'
require 'pathname'
# require 'coveralls'
# require 'simplecov'
# require 'codeclimate-test-reporter'

require 'salt-lint/printer'
require 'salt-lint/actions'

# SimpleCov.formatter = SimpleCov::Formatter::MultiFormatter[
#   SimpleCov::Formatter::HTMLFormatter,
#   Coveralls::SimpleCov::Formatter
# ]

# SimpleCov.start
# CodeClimate::TestReporter.start

RSpec.configure do |c|
  c.fail_fast = true
  c.include ArubaDoubles

  c.before :each do
    Aruba::RSpec.setup
  end

  c.after :each do
    Aruba::RSpec.teardown
  end

  c.before(:all, &:silence_output)
  c.after(:all,  &:enable_output)
end

root_path = Pathname.new(__FILE__).parent.parent
ENV['PATH'] = "#{root_path.join('bin').to_s}#{File::PATH_SEPARATOR}#{ENV['PATH']}"

public

def silence_output
  # Store the original stderr and stdout in order to restore them later
  @original_stderr = $stderr
  @original_stdout = $stdout

  # Redirect stderr and stdout
  $stderr = File.new(File.join('/dev', 'null'), 'w')
  $stdout = File.new(File.join('/dev', 'null'), 'w')
end

# Replace stderr and stdout so anything else is output correctly
def enable_output
  $stderr = @original_stderr
  $stdout = @original_stdout
  @original_stderr = nil
  @original_stdout = nil
end