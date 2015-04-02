require 'salt-lint/version'
require 'salt-lint/runner'
require 'salt-lint/tests'

# Main salt-lint module declaration.
module SaltLint
  def self.runner
    @runner ||= SaltLint::Runner.new(*ARGV)
  end
end
