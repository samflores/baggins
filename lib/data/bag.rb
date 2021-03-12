# frozen-string-literal: true

module Baggins
  # Bag
  class Bag
    attr_reader :name, :children

    def initialize(name:, children:)
      @name = name
      @children = children
    end

    def ==(other)
      @name == other.name && @children == other.children
    end

    def hold?(name)
      children.any? { |child, _| child == name }
    end

    def children_count
      children.reduce(0) do |sum, (_, quantity)|
        sum += quantity
        sum
      end
    end
  end
end
