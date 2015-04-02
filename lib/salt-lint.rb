require 'salt-lint/version'
require 'salt-lint/runner'

# Main salt-lint module declaration.
module SaltLint
  def self.runner
    @runner ||= SaltLint::Runner.new(*ARGV)
  end
end
