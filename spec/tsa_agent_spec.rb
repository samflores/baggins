# frozen-string-literal: true

require 'spec_helper'
require 'tsa_agent'

describe TSAAgent do
  it 'lists which bags are valid to carry a given bag' do
    filename = File.join(
      File.dirname(__FILE__),
      'fixtures',
      'smallinput.txt'
    )
    agent = TSAAgent.new(filename)
    valid_bags = agent.valid_bags_for('shiny gold').sort
    _(valid_bags).must_equal(
      [
        'bright white',
        'muted yellow',
        'dark orange',
        'light red'
      ].sort
    )
  end

  it 'counts the number of bags inside another bag' do
    filename = File.join(
      File.dirname(__FILE__),
      'fixtures',
      'smallinput2.txt'
    )
    agent = TSAAgent.new(filename)
    valid_bags = agent.count_bags_inside('shiny gold')
    _(valid_bags).must_equal(126)
  end
end
