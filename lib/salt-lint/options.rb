require 'trollop'

module SaltLint
  # Parsing user arguments / parameters class
  # ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  class Options
    # Actions based on parsed command line arguments
    def self.act
      # Scanning for files in
      if $arguments.scan_given
        list_of_files = SaltLint::Actions.scan
        if list_of_files.count > 0
          SaltLint::Actions.scan.each do |f|
            SaltLint::Actions.check_rules(f)
          end
        end
      end
    end


    # Parsing command line arguments
    def self.parse(args)
      opts = Trollop::options do
        version "salt-lint #{SaltLint::VERSION} (c) 2015 Lukasz Raczylo <lukasz@raczylo.com>\nVisit https://github.com/lukaszraczylo/salt-lint for source code"
        banner <<-EOS
salt-lint is a first linter for Salt state files.
Usage:
  $ salt-lint [options]

where [options] are:
EOS
        opt :debug,   'Enable debug mode', default: 0
        opt :file,    'File to check against', type: :string
        opt :scan,    'Traversal scan of current directory and sub dirs', type: :string
      end
      $debug = opts.debug.to_i
      return opts
    end
  end
end
