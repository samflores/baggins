#!/usr/bin/ruby
# frozen-string-literal: true

require 'bundler/setup'
require 'optparse'
require_relative 'lib/tsa_agent'

module Baggins
  # Baggins::Main
  class Main
    OPTIONS = [
      [:rules_file, 'FILE', 'r', 'rules-file', 'The path to the file with the rules'],
      [:bag, 'BAG', 'b', 'bag', 'The bag you want to check'],
      [:list, nil, 'l', 'list', 'List all valid bags besides counting then'],
      [:count_children, nil, 'c', 'children-count', 'Count the number os nested children']
    ].freeze

    def initialize(args)
      @options = { list: false }

      options_parser.parse!(args)
    end

    def run!
      return if handle_help_command
      return if assert_option_defined(:rules_file, 'You must specifiy the --rules-file (-f) option')
      return if assert_option_defined(:bag, 'You must specifiy the --bag (-b) option')
      return if assert_mutex_options(:count_children, :list,
                                     'You cannot specify --list (-l) and --children-count (-c) together')

      @options[:count_children] ? run_count_children : run_valid_bags
    end

    private

    def tsa_agent
      TSAAgent.new(@options[:rules_file])
    end

    def valid_bags
      tsa_agent
        .valid_bags_for(@options[:bag])
        .sort
    end

    def handle_help_command
      return unless @help_message

      puts @help_message
      true
    end

    def run_count_children
      count = tsa_agent.count_bags_inside(@options[:bag])
      one = count == 1
      puts "There #{one ? 'is' : 'are'} #{count} bag#{one ? '' : 's'} inside a #{@options[:bag]} bag"
    end

    def run_valid_bags
      count = valid_bags.count
      one = count == 1
      puts "There #{one ? 'is' : 'are'} #{count} valid bag#{one ? '' : 's'} to carry a #{@options[:bag]} bag"
      return unless @options[:list]

      puts(count == 1 ? 'Here it is:' : 'Here they are:')
      pp valid_bags
    end

    def assert_option_defined(opt, msg)
      return if @options[opt]

      puts msg
      true
    end

    def assert_mutex_options(opt1, opt2, msg)
      return unless @options[opt1] & @options[opt2]

      puts msg
      true
    end

    def options_parser
      OptionParser.new do |opts|
        opts.banner = 'Usage: baggins.rb [options]'

        OPTIONS.each do |(name, arg, short, full, msg)|
          opts.on("-#{short}#{arg}", "--#{full}#{"=#{arg}" if arg}", msg) { |x| @options[name] = arg ? x : true }
        end
        opts.on('-h', '--help', 'Prints this help') { @help_message = opts }
      end
    end
  end
end

# :nocov:
Baggins::Main.new(ARGV).run! if $PROGRAM_NAME == __FILE__
# :nocov:
