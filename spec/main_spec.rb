# frozen-string-literal: true

require 'spec_helper'
require 'baggins'

describe Baggins::Main do
  it 'prints a help message' do
    args = %w[-h]

    expected = <<~OUT
      Usage: baggins.rb [options]
          -r, --rules-file=FILE            The path to the file with the rules
          -b, --bag=BAG                    The bag you want to check
          -l, --list                       List all valid bags besides counting then
          -c, --children-count             Count the number os nested children
          -h, --help                       Prints this help
    OUT

    _ { Baggins::Main.new(args).run! }.must_output(expected)
  end

  it 'requires the -r argument' do
    args = %w[
      -b shiny\ gold
      -l
      -c
    ]

    expected = <<~OUT
      You must specifiy the --rules-file (-f) option
    OUT

    _ { Baggins::Main.new(args).run! }.must_output(expected)
  end

  it 'requires the -b argument' do
    args = %w[
      -r spec/fixtures/smallinput.txt
      -l
      -c
    ]

    expected = <<~OUT
      You must specifiy the --bag (-b) option
    OUT

    _ { Baggins::Main.new(args).run! }.must_output(expected)
  end

  it 'fails with both -l and -c' do
    args = %w[
      -b shiny\ gold
      -r spec/fixtures/smallinput.txt
      -l
      -c
    ]

    expected = <<~OUT
      You cannot specify --list (-l) and --children-count (-c) together
    OUT

    _ { Baggins::Main.new(args).run! }.must_output(expected)
  end

  it 'displays the number of valid bags by default - plural' do
    args = %w[
      -b shiny\ gold
      -r spec/fixtures/smallinput.txt
    ]

    expected = <<~OUT
      There are 4 valid bags to carry a shiny gold bag
    OUT

    _ { Baggins::Main.new(args).run! }.must_output(expected)
  end

  it 'displays the number of valid bags by default - singular' do
    args = %w[
      -b shiny\ gold
      -r spec/fixtures/singleinput.txt
    ]

    expected = <<~OUT
      There is 1 valid bag to carry a shiny gold bag
    OUT

    _ { Baggins::Main.new(args).run! }.must_output(expected)
  end

  it 'displays the list of valid bags with the -l argument - plural' do
    args = %w[
      -b shiny\ gold
      -r spec/fixtures/smallinput.txt
      -l
    ]

    expected = <<~OUT
      There are 4 valid bags to carry a shiny gold bag
      Here they are:
      ["bright white", "dark orange", "light red", "muted yellow"]
    OUT

    _ { Baggins::Main.new(args).run! }.must_output(expected)
  end

  it 'displays the list of valid bags with the -l argument - singular' do
    args = %w[
      -b shiny\ gold
      -r spec/fixtures/singleinput.txt
      -l
    ]

    expected = <<~OUT
      There is 1 valid bag to carry a shiny gold bag
      Here it is:
      ["bright white"]
    OUT

    _ { Baggins::Main.new(args).run! }.must_output(expected)
  end

  it 'displays the childs count with the -c argument - plural' do
    args = %w[
      -b shiny\ gold
      -r spec/fixtures/smallinput2.txt
      -c
    ]

    expected = <<~OUT
      There are 126 bags inside a shiny gold bag
    OUT

    _ { Baggins::Main.new(args).run! }.must_output(expected)
  end

  it 'displays the childs count with the -c argument - singular' do
    args = %w[
      -b shiny\ gold
      -r spec/fixtures/singleinput2.txt
      -c
    ]

    expected = <<~OUT
      There is 1 bag inside a shiny gold bag
    OUT

    _ { Baggins::Main.new(args).run! }.must_output(expected)
  end
end
