require "benchmark/ips"
require "optparse"

Benchmark.ips { |x|
  doc = nil

  parser = OptionParser.new
  parser.on('--cext', 'Use GraphQL C extension') { require "graphql/c_parser" }
  parser.on('--ruby-racc', 'Use Ruby version of Racc') { $LOAD_PATH << "lib" }
  parser.on('--tinygql', 'Include TinyGQL') {
    x.report("tinygql") { TinyGQL.parse(doc) }
  }
  parser.parse!

  # Make sure require goes after LOAD_PATH manipulation
  require "graphql"
  require "tinygql"

  doc = ARGF.read

  x.report("graphql") { GraphQL.parse(doc) }
}

