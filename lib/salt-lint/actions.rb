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
        test_suite_methods.each do |m|
          if ! $invalid_yaml[f]
            checks_went_fine_tmp = SaltLint::Tests.send(m, line_counter, l, f)
            checks_went_fine_tmp == false ? checks_went_fine = false : nil
          end
        end
        line_counter += 1
      end
      checks_went_fine ? Printer.print('success', "File looks fine: #{f}") : Printer.print('error', "Found errors in file: #{f}")
      return checks_went_fine
    end

    # Scans folder specified as argument --scan for SLS files and returns array
    def self.scan
      files = Dir.glob( $arguments.scan + "**/*.sls")
      if files and files.count > 0
        return files
      else
        Printer.print('error', 'No salt state files found.')
        exit 1
      end
    end
  end
end