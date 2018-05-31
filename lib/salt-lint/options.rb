require 'trollop'

module SaltLint
  # Parsing user arguments / parameters class
  # ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  class Options
    # Actions based on parsed command line arguments
    def self.act
      # Scanning for files in
      errors = 0
      if $arguments.scan_given
        list_of_files = SaltLint::Actions.scan
        if list_of_files.count > 0
          SaltLint::Actions.scan.each do |f|
            if(!SaltLint::Actions.check_rules(f))
              errors = errors+1
            end
          end
        end
      elsif $arguments.file_given
        if(!SaltLint::Actions.check_rules($arguments.file))
          errors = errors+1
        end
      end
      puts("\n----- SUMMARY: -----")
      Printer.print('warning', "Total errors found: #{errors}")
      if(errors>0)
        exit 1
      else
        exit 0
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

        opt :check_newlines, 'Check for newline at the end of the file', default: true, short: :none
        opt :check_double_quotes, 'Check for double quotes without variables', default: true, short: :none
        opt :check_whitespaces, 'Check for whitespaces at the end of the line', default: true, short: :none
        opt :check_line_length, 'Check lines length', default: true, short: :none
        opt :check_single_word, 'Check for single word declaration', default: true, short: :none
        opt :check_quoted_boolean, 'Check for quoted booleans', default: true, short: :none
        opt :check_quoted_file_mode, 'Check for unquoted file modes', default: true, short: :none
        opt :check_tabs, 'Check if tabs used instead of spaces', default: true, short: :none

      end
      $debug = opts.debug.to_i
      return opts
    end
  end
end
