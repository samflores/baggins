# frozen-string-literal: true

require 'treetop'

require_relative 'data/bag'
require_relative 'data/rules_enforcer'

Treetop.load 'rules_grammar'

# RulesParser
class RulesParser
  def initialize(input)
    @input = input
    @parser = RulesGrammarParser.new
  end

  def rules
    @rules ||= @parser.parse(@input).eval
  end

  def enforcer
    @enforcer ||= Baggins::RulesEnforcer.new(rules)
  end
end
