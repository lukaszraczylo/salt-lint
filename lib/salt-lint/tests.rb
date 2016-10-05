require 'yaml'

module SaltLint
  # Main class for all the tests.
  class Tests

    # Helper: Checking for whitespaces
    def self.check_for_regexp(line_number, line, file, regex, debug_msg, warning_msg)
      Printer.print('debug', debug_msg, 5)
      ! (line =~ Regexp.new(regex)).nil? ? is_ok = false : is_ok = true
      if ! is_ok
        Printer.print('warning', warning_msg)
      end
      return is_ok
    end

    # Test content: Check context and block all the single-word declarations
    def self.check_if_single_word_declaration(line_number, line, file)
      is_ok = true
      if $arguments.check_single_word
        Printer.print('debug', "Looking for single word declarations in #{file}", 5)
        if line =~ /(pkg|file|service):\n/
            f = File.readlines(file)[line_number-1..line_number+2]
            ( f[2] =~ /^\n$/ && f[1] =~ /- \w+\n$/ ) ? is_ok = true : is_ok = false
            if ! $invalid_oneword.has_key?(file) && is_ok == false
              Printer.print('warning', "Found single line declaration in #{file}:#{line_number-1}-#{line_number+1}")
              $invalid_oneword[file] = is_ok
            end
        end
      end
      return is_ok
    end

    # Test content: Checking given file for no newline at the end of the file.
    def self.check_for_no_newline(line_number, line, file)
      is_ok = true
        if $arguments.check_newlines
        Printer.print('debug', "Checking for no-newline at the end of the file in file #{file}", 5)
        f = File.readlines(file).last
        f.match(/^\n$/) ? is_ok = true : is_ok = false
        if ! $invalid_newline.has_key?(file) && is_ok == false
          Printer.print('warning', "No newline at the end of the file #{file}")
          $invalid_newline[file] = is_ok
        end
      end
      return is_ok
    end

    # Test content: Checking if given line isn't longer than 80 characters.
    def self.check_line_length(line_number, line, file)
      is_ok = true
      if $arguments.check_line_length
        Printer.print('debug', "Checking line length: #{line_number}", 5)
        line.length > 80 ? is_ok = false : nil
        if ! is_ok
          Printer.print('warning', "Line length above 80 characters: #{file}:#{line_number}")
        end
      end
      return is_ok
    end


    # Test content: Check for tabs used instead of spaces.
    def self.check_if_tabs_used(line_number, line, file)
      if $arguments.check_tabs
        check_for_regexp(line_number, line, file, /^[\t]+/, "Checking for tabs presence: #{line_number}", "Found tabs used instead of spaces: #{file}:#{line_number}")
      else
        return true
      end
    end

    # Test content: Checking given line for trailing whitespaces.
    def self.check_trailing_whitespace(line_number, line, file)
      if $arguments.check_whitespaces
        check_for_regexp(line_number, line, file, /[ \t]+$/, "Checking for trailing whitespaces: #{line_number}", "Trailing whitespace character found: #{file}:#{line_number}")
      else
        return true
      end
    end

    # Test content: Checking if given line contains double quoted content without
    # variable.
    def self.check_double_quotes(line_number, line, file)
      if $arguments.check_double_quotes
        check_for_regexp(line_number, line, file, /\"(?!{+).*(?!}+)\"/, "Checking for double quotes: #{line_number}", "Using double quotes with no variables: #{file}:#{line_number}")
      else
        return true
      end
    end

    # Test content: Checking if there's quoted boolean value present.
    def self.check_quoted_boolean(line_number, line, file)
      if $arguments.check_quoted_boolean
        check_for_regexp(line_number, line, file, /\s+(\"|\')(true|false)(\"|\')$/, "Checking for quoted booleans: #{line_number}", "Quoted boolean found: #{file}:#{line_number}")
      else
        return true
      end
    end

    # Test content: Check if file mode with leading zero is wrapped into single quotes
    def self.check_file_mode_single_quotes(line_number, line, file)
      if $arguments.check_quoted_file_mode
        check_for_regexp(line_number, line, file, /mode\:\s\d{3,4}$/, "Checking if file mode is wrapped in single quotes: #{line_number}", "Unquoted file mode found: #{file}:#{line_number}")
      else
        return true
      end
    end
  end
end
