$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))

require 'salt-lint'
require 'rspec'
require 'aruba/rspec'
require 'pathname'
require 'ostruct'

require 'salt-lint/printer'
require 'salt-lint/actions'

RSpec.configure do |c|
  c.fail_fast = true
  c.include ArubaDoubles

  c.before :each do
    Aruba::RSpec.setup
  end

  c.after :each do
    Aruba::RSpec.teardown
  end
end

root_path = Pathname.new(__FILE__).parent.parent
ENV['PATH'] = "#{root_path.join('bin').to_s}#{File::PATH_SEPARATOR}#{ENV['PATH']}"