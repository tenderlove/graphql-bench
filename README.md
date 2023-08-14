# GraphQL benchmark

Simple benchmark of two GraphQL parsers written for Ruby.

These were written to study the performance of YJIT under various conditions.
Racc makes many "cross boundary" calls (Ruby -> C -> Ruby), but also has a pure Ruby runtime implementation.
That means we can test the how YJIT performs against a C implementation without rewriting upstream code.

Second, there is a GraphQL C extension that replaces the Ruby parser with a parser written in C.
TinyGQL aims to be a fast GraphQL parser written in pure Ruby.
This allows us to study whether it is worthwhile to rewrite slow code in C, or rewrite it in Ruby.

## Running the Benchmark

1. Normal GraphQL benchmark (baseline):

`ruby graphql-bench.rb negotiate.gql`

2. GraphQL benchmark with Ruby implementation of Racc:

`ruby graphql-bench.rb --ruby-racc negotiate.gql`

3. GraphQL benchmark with GraphQL C extention + TinyGQL:

`ruby graphql-bench.rb --cext --tinygql negotiate.gql`

4. GraphQL benchmark with GraphQL C extention + TinyGQL + YJIT:

`ruby --jit graphql-bench.rb --cext --tinygql negotiate.gql`
