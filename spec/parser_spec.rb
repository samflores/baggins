# frozen-string-literal: true

require 'spec_helper'
require 'parser'

describe RulesParser do
  it 'parses a single line input' do
    input = 'light red bags contain 1 bright white bag, 2 muted yellow bags.'
    result = RulesParser.new(input).rules
    _(result).must_equal(
      [
        Baggins::Bag.new(
          name: 'light red',
          children: { 'bright white' => 1, 'muted yellow' => 2 }
        )
      ]
    )
  end

  it 'parses a single line input with no children bags' do
    input = 'light red bags contain no other bags.'
    result = RulesParser.new(input).rules
    _(result).must_equal(
      [
        Baggins::Bag.new(
          name: 'light red',
          children: {}
        )
      ]
    )
  end

  it 'parses a multiline input' do
    input = <<~INPUT
      light red bags contain 1 bright white bag, 2 muted yellow bags.
      bright white bags contain 2 light blue bags.
    INPUT

    result = RulesParser.new(input).rules
    _(result).must_equal(
      [
        Baggins::Bag.new(
          name: 'light red',
          children: { 'bright white' => 1, 'muted yellow' => 2 }
        ),
        Baggins::Bag.new(
          name: 'bright white',
          children: { 'light blue' => 2 }
        )
      ]
    )
  end

  it 'parses a multiline input where some bags have no children' do
    input = <<~INPUT
      light red bags contain 1 bright white bag, 2 muted yellow bags.
      bright white bags contain 2 light blue bags.
      light blue bags contain no other bags.
    INPUT

    result = RulesParser.new(input).rules
    _(result).must_equal(
      [
        Baggins::Bag.new(
          name: 'light red',
          children: { 'bright white' => 1, 'muted yellow' => 2 }
        ),
        Baggins::Bag.new(
          name: 'bright white',
          children: { 'light blue' => 2 }
        ),
        Baggins::Bag.new(
          name: 'light blue',
          children: {}
        )
      ]
    )
  end
end
