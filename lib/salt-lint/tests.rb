require 'yaml'

module SaltLint
  # Main class for all the tests.
  class Tests

    # Helper: Checking for whitespaces
    def self.check_for_regexp(line_number, line, file, regex, debug_msg, warning_msg)
      is_ok = true
      Printer.print('debug', debug_msg, 5)
      line.match(regex) ? is_ok = false : nil
      if ! is_ok
        Printer.print('warning', warning_msg)
      end
      return is_ok
    end

    # Test content: Check context and block all the single-word declarations
    def self.check_if_single_word_declaration(line_number, line, file)
      is_ok = true
      Printer.print('debug', "Looking for single word declarations in #{file}", 5)
      if line =~ /(pkg|file|service):\n/
          f = File.readlines(file)[line_number-1..line_number+2]
          ( f[2] =~ /^\n$/ && f[1] =~ /- \w+\n$/ ) ? is_ok = true : is_ok = false
          if ! $invalid_oneword.has_key?(file) && is_ok == false
            Printer.print('warning', "Found single line declaration in #{file}:#{line_number-1}-#{line_number+2}")
            $invalid_oneword[file] = is_ok
          end
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
    # Test disabled as it returns false positive when there's salt pillars declaration present
    # def self.check_if_proper_yaml(line_number, line, file)
    #   is_ok = true
    #   begin
    #     YAML.load_file(file)
    #   rescue Psych::SyntaxError
    #     is_ok = false
    #     if ! $invalid_yaml.has_key?(file)
    #       Printer.print('warning', "File #{file} is not YAML. Unable to parse.")
    #       $invalid_yaml[file] = true
    #     end
    #   end
    #   return is_ok
    # end

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

    # Test content: Checking given line for trailing whitespaces.
    def self.check_trailing_whitespace(line_number, line, file)
      check_for_regexp(line_number, line, file, /[ \t]+$/, "Checking for trailing whitespaces: #{line_number}", "Trailing whitespace character found: #{file}:#{line_number}")
    end

    # Test content: Checking if given line contains double quoted content without
    # variable.
    def self.check_double_quotes(line_number, line, file)
      check_for_regexp(line_number, line, file, /\"(?!{+).*(?!}+)\"/, "Checking for double quotes: #{line_number}", "Using double quotes with no variables: #{file}:#{line_number}")
    end
  end
end
