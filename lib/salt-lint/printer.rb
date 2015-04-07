# Printer module
# ~~~~~~~~~~~~~~
# It's responsible for printing, duh.

require 'colorize'

module Printer
  def self.print(msg_type = 'info', message = 'no message specified', debug_level = 0)
    prefix  = nil
    show    = true
    kill    = false
    case msg_type
      when 'debug'
        prefix  = '[d]'
        color   = 'black'
        background = 'on_blue'
        show    = false
      when 'warning'
        prefix  = '[!]'
        color   = 'light_black'
      when 'error'
        prefix  = '[!!!]'
        color   = 'red'
        kill    = true
      when 'question'
        prefix  = '[?]'
        color   = 'light_blue'
      when 'success'
        prefix  = '[:)]'
        color   = 'light_green'
        background = 'on_black'
      else
        prefix  = '[i]'
        color   = 'white'
    end

    # If debug message requested - check if debug flag has been enabled and which
    # level of debug if so. If global debug level is higher or equal to message
    # debug level - print it out.
    if msg_type == 'debug' and $debug != false and debug_level <= $debug
      show = true
    end

    if show == true
      if background
        puts "#{prefix} #{message}".send(color.to_sym).send(background.to_sym)
      else
        puts "#{prefix} #{message}".send(color.to_sym)
      end
    end

    # Kill switch for error messages. Using this one to abort script run as
    # something went really wrong there.
  end
end