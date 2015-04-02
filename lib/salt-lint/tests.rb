require 'yaml'

module SaltLint
  # Main class for all the tests.
  class Tests

    # Test content: Checking given line for trailing whitespaces.
    def self.check_trailing_whitespace(line_number, line, file)
      is_ok = true
      Printer.print('debug', "Checking for trailing whitespaces: #{line_number}", 5)
      line.match(/[ \t]+$/) ? is_ok = false : nil
      if ! is_ok
        Printer.print('warning', "Trailing whitespace character found: #{file}:#{line_number}")
      end
      return is_ok
    end

    # Test content: Checking given file for no newline at the end of the file.
    def self.check_for_no_newline(line_number, line, file)
      is_ok = true
      Printer.print('debug', "Checking for no-newline at the end of the file in file #{file}", 5)
      f = File.readlines(file).last
      f.match(/^\n$/) ? is_ok = true : is_ok = false
      if ! $invalid_newline.has_key?(file) && is_ok == false
        Printer.print('warning', "No newline at the end of the file #{file}")
        $invalid_newline[file] = is_ok
      end
      return is_ok
    end

    # Test content: Checking if given file is a valid YAML file.
    def self.check_if_proper_yaml(line_number, line, file)
      is_ok = true
      begin
        YAML.load_file(file)
      rescue Psych::SyntaxError
        is_ok = false
        if ! $invalid_yaml.has_key?(file)
          Printer.print('warning', "File #{file} is not YAML. Unable to parse.")
          $invalid_yaml[file] = true
        end
      end
      return is_ok
    end

    # Test content: Checking if given line isn't longer than 80 characters.
    def self.check_line_length(line_number, line, file)
      is_ok = true
      Printer.print('debug', "Checking line length: #{line_number}", 5)
      line.length > 80 ? is_ok = false : nil
      if ! is_ok
        Printer.print('warning', "Line length above 80 characters: #{file}:#{line_number}")
      end
      return is_ok
    end

    # Test content: Checking if given line contains double quoted content without
    # variable.
    def self.check_double_quotes(line_number, line, file)
      is_ok = true
      Printer.print('debug', "Checking for double quotes: #{line_number}", 5)
      line.match(/\"(?!{+).*(?!}+)\"/) ? is_ok = false : nil
      if ! is_ok
        Printer.print('warning', "Using double quotes with no variables: #{file}:#{line_number}")
      end
      return is_ok
    end
  end
end
