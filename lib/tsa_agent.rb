# frozen-string-literal: true

require 'rubygems'

require_relative 'parser'

# TSAAgent
class TSAAgent
  def initialize(filepath)
    @filepath = filepath
  end

  def valid_bags_for(bag_name)
    enforcer.containers_for(bag_name)
  end

  def count_bags_inside(bag_name)
    enforcer.children_count(bag_name)
  end

  private

  def enforcer
    RulesParser.new(File.read(@filepath)).enforcer
  end
end
