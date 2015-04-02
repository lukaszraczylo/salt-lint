module SaltLint
  # Executing appropriate actions
  # ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  class Actions
    # Check if files comply with linter rules
    def self.check_rules(f)
      checks_went_fine = true
      Printer.print('debug', "Checking file: #{f}", 5)
      # ADD FILTER CHECKING
      return checks_went_fine
    end

    # Scans folder specified as argument --scan for SLS files and returns array
    def self.scan
      files = Dir.glob( $arguments.scan + "**/*.sls")
      if files and files.count > 0
        return files
      else
        Printer.print('error', 'No salt state files found.')
      end
    end
  end
end