# frozen-string-literal: true

require 'spec_helper'
require 'data/rules_enforcer'

describe Baggins::RulesEnforcer do
  before do
    bags = [
      Baggins::Bag.new(name: 'bright black', children: { 'dark white' => 1 }),
      Baggins::Bag.new(name: 'dark white', children: { 'smokey pink' => 2 }),
      Baggins::Bag.new(name: 'smokey pink', children: { 'dark red' => 1, 'invisible green' => 2 }),
      Baggins::Bag.new(name: 'dark red', children: {}),
      Baggins::Bag.new(name: 'invisivle red', children: {})
    ]
    @index = Baggins::RulesEnforcer.new(bags)
  end

  it 'checks whether a container can contain another bag' do
    result = @index.can?(container: 'bright black', hold: 'dark white')
    _(result).must_equal(true)
  end

  it 'checks whether a container can contain another bag indirectly' do
    result = @index.can?(container: 'bright black', hold: 'smokey pink')
    _(result).must_equal(true)
  end

  it 'checks whether a container can contain another bag with multiple indirection levels' do
    result = @index.can?(container: 'bright black', hold: 'invisible green')
    _(result).must_equal(true)
  end

  it 'checks whether a container can NOT contain another, not even indirectly' do
    result = @index.can?(container: 'dark white', hold: 'bright black')
    _(result).must_equal(false)
  end

  it 'lists all bags that can contain another bag' do
    result = @index.containers_for('smokey pink')
    _(result).must_equal(['bright black', 'dark white'])
  end

  it 'count all children recursivelly' do
    result = @index.children_count('bright black')
    _(result).must_equal(9)
  end
end
