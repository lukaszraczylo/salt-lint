require 'salt-lint/version'
require 'salt-lint/options'
require 'salt-lint/printer'
require 'salt-lint/actions'

require 'awesome_print'

module SaltLint
  # Main class executed on every run. Just to spin things up.
  # ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  class Runner
    def initialize(*args)
      $arguments = SaltLint::Options.parse(args)
      ap $arguments
      ap $debug
      SaltLint::Options.act
    end
  end
end
