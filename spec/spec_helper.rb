# frozen-string-literal: true

require 'bundler/setup'
require 'minitest'
require 'simplecov'
require 'minitest/autorun'

if ENV['COVERAGE']
  SimpleCov.start do
    enable_coverage :branch
    filters.clear

    track_files '**/*.rb'
    add_filter 'spec'
  end
end
