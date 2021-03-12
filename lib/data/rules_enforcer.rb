# frozen-string-literal: true

require_relative 'bag'

module Baggins
  # Index
  class RulesEnforcer
    def initialize(bags)
      @bags = bags
      @indexed = @bags.each_with_object({}) { |bag, hsh| hsh[bag.name] = bag }
    end

    def can?(container:, hold:)
      bag = @indexed[container]
      return false unless bag

      bag.hold?(hold) ||
        bag.children.any? { |child, _| can?(container: child, hold: hold) }
    end

    def containers_for(bag)
      @cache ||= {}

      @cache[bag] ||= @bags.each_with_object([]) do |container, res|
        res << container.name if can?(container: container.name, hold: bag)
      end
    end

    def children_count(container)
      bag = @indexed[container]
      return 0 unless bag

      direct_children_count = bag.children_count
      indirect_children_count = bag.children.reduce(0) do |count, (child, num_of_child)|
        count += num_of_child * children_count(child)
        count
      end

      direct_children_count + indirect_children_count
    end
  end
end
