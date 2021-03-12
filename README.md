# Baggins

My solution for one of 2020's Advent of Code puzzles https://adventofcode.com/2020/day/7

# Dependencies

- Ruby (built with 3.0.0p0, but older versions might work as well)

# Setup

- `git clone git@github.com:samflores/baggins.git`
- `cd baggins`
- `bundle install`

# Usage

- First part: `ruby -Ilib baggins.rb -r /path/to/downloaded/puzzle-input.txt -b 'shiny gold'`
- Second part: `ruby -Ilib baggins.rb -r /path/to/downloaded/puzzle-input.txt -b 'shiny gold' --children-count` second part
- More usage options: `ruby -Ilib baggins.rb -h`

# Testing and linting

- Run linter: `rubocop`
- Run specs: `rake`
- Report specs coverage: `rake coverage`

# License

Copyright © 2021 Samuel Flores <me@samflor.es>

This work is free. You can redistribute it and/or modify it under the
terms of the Do What The Fuck You Want To Public License, Version 2,
as published by Sam Hocevar. See the COPYING file for more details.
