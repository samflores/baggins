# frozen-string-literal: true

require 'spec_helper'
require 'data/bag'

describe Baggins::Bag do
  before do
    @bag = Baggins::Bag.new(name: 'bright black', children: { 'dark white' => 1, 'muted yellow' => 2 })
  end

  it 'works' do
    _(@bag.name).must_equal('bright black') &
      _(@bag.children['dark white']).must_equal(1)
  end

  it 'checks whether it can contain other bag' do
    _(@bag.hold?('dark white')).must_equal(true) &
      _(@bag.hold?('blood red')).must_equal(false)
  end

  it 'counts the number of imediate children a bag has' do
    _(@bag.children_count).must_equal(3)
  end
end
