require 'find'

module SaltLint
  # Executing appropriate actions
  # ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  class Actions
    # Check if files comply with linter rules
    def self.check_rules(f)
      $invalid_yaml     = Hash.new
      $invalid_newline  = Hash.new
      $invalid_oneword  = Hash.new

      checks_went_fine = true
      Printer.print('debug', "Checking file: #{f}", 5)
      test_suite_methods = SaltLint::Tests.methods(false).sort - [ :check_for_regexp ]
      line_counter = 1
      File.readlines(f).each do |l|
        skip = false
        tmp_l = l.gsub(/\s+/, '')
        # Comments
        if tmp_l =~ /\{?#(.+)?\}?/
          skip = true
        # Empty lines
        elsif tmp_l =~ /^$/
          skip = true
        # Functions
        elsif tmp_l =~ /\{+.+\(.+\).+\}+/
          skip = true
        # Variables
        elsif tmp_l =~ /\{\{.+\}\}/
          l = l.gsub(/\{\{.+\}\}/, 'random_string')
        # If / Else blocks
        elsif tmp_l =~ /^\{\%.*\%\}$/
          skip = true
        end
        if ! skip
          test_suite_methods.each do |m|
            if ! $invalid_yaml[f]
              checks_went_fine_tmp = SaltLint::Tests.send(m, line_counter, l, f)
              checks_went_fine_tmp == false ? checks_went_fine = false : nil
            end
          end
        end
        line_counter += 1
      end
      checks_went_fine ? Printer.print('success', "File looks fine: #{f}") : Printer.print('error', "Found errors in file: #{f}")
      return checks_went_fine
    end

    # Scans folder specified as argument --scan for SLS files and returns array
    def self.scan
      # files = Dir.glob( $arguments.scan + "**/*")
      files_to_return = Array.new
      Find.find($arguments.scan).to_a.each do |f|
        if f =~ /.*\.sls$/
          files_to_return.push(f)
        end
      end
      if files_to_return.count > 0
        return files_to_return
      else
        Printer.print('error', 'No salt state files found.')
        exit 1
      end
    end
  end
end