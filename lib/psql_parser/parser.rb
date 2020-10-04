# frozen_string_literal: true

require 'treetop'
require_relative './psql_node_extensions'
require_relative './psql_schema_node_extensions'

# Postgres SQL Parser gem.
# This is a variation of the VsqlParser gem.
#
module PsqlParser

  # ------------------------------
  # @class Parser
  #
  # @responsibility Parse a file and return an AST or raise an error
  #
  # @description Parse a Postgres Schema or SQL file,
  #   using Treetop to define the grammar and create the parser class needed.
  #   This is a variation of the VsqlParser gem.
  #
  class Parser

    # Treetop grammar for Postgres SQL
    PSQL_GRAMMAR_FN = 'psql_parser.treetop'

    # Treetop grammar for a Postgres Schema file
    FILE_GRAMMAR_FN = 'psql-schema_parser.treetop'

    # maximum depth to generate for a dot (graphviz) file
    MAX_DOT_LEVEL = 4
    # maximum length of string to show, truncate and use else use '...'
    MAX_NODETEXT_LEN = 1000

    # This call to Treetop will create a Parser class based on the root name in the grammar file.
    grammars = [PSQL_GRAMMAR_FN, FILE_GRAMMAR_FN].freeze

    grammars.each { |grammarfile| Treetop.load(File.join(__dir__, grammarfile)) }

    # -------------------------------------------


    def self.sql_parser
      @@sql_parser ||= PSqlParser.new
    end

    def self.schema_parser
      @@schema_parser ||= PSqlSchemaParser.new
    end

    def self.parse_schema(sql,
                          show_tree: true,
                          cleanup_tree: false,
                          dot_file: false)
      parse(sql,
            grammarparser: schema_parser,
            show_tree: show_tree,
            cleanup_tree: cleanup_tree,
            dot_file: dot_file)
    end

    def self.parse(sql,
                   grammarparser: sql_parser,
                   show_tree: false,
                   cleanup_tree: false,
                   dot_file: false)

      d_sql = sql.downcase # REQUIRED!

      tree = grammarparser.parse(d_sql).tap do
        d_sql.replace(sql)
      end

      # If the AST is nil then there was an error during parsing
      # we need to report a simple error message to help the user
      raise Exception, "#{grammarparser.failure_reason} #{parser_error_details(sql, grammarparser)}" if tree.nil?

      result_tree = cleanup_tree ? reject_unwanted_nodes(tree) : tree
      output_tree(result_tree, show: show_tree, to_dot_file: dot_file)

      result_tree
    end

    # Display and/or create a dot file based on the options given
    def self.output_tree(tree, show: false, to_dot_file: false)
      puts tree.inspect if show

      return unless to_dot_file

      dot_fname = File.join(__dir__, "parser-#{Time.now.to_i}")
      if tree.is_a? Array
        tree.each_with_index { |t, i| write_dot(t, "#{dot_fname}-#{i}") }
      else
        write_dot(tree, "#{dot_fname}-0")
      end
    end

    def self.parser_error_details(parsed_str, parser)
      fail_index = parser.max_terminal_failure_index
      "\n fail_index = #{fail_index}\n\n" +
        (fail_index.positive? ? parsed_str[0..(fail_index - 1)] : '') + ':' +
        parsed_str[fail_index..-1] +
        "\n\n"
    end


    # Here are some tools to use to define which kinds of nodes to reject/remove
    #  in order to create a 'cleaner' tree:
    #
    # NOISY_NAMES = [].freeze
    # NOISY_NAMES = ['Treetop::Runtime::SyntaxNode', 'PSql::Space'].freeze
    #
    # REJECT_TEST = lambda do |node|
    #   em = node.extension_modules
    #   interesting_methods = node.methods - [em.last ? em.last.methods : nil] - node.class.instance_methods
    #   interesting_methods.empty?
    # end
    #
    # reject a node if
    #   there are no 'inner methods' (which are names of rules in the grammar file)
    #    == the length of the String for the node is 1 or 0 (empty)
    #      -- which are usually literals
    #        (e.g. letters, numbers, punctuation, space, or empty)
    REJECT_TEST = lambda do |node|
      inspect_matcher = /SyntaxNode(?<inner_node>\+\w+)?[^"]+"(?<inner_methods>[^"]*)"/
      inner_node_and_methods = inspect_matcher.match(node.inspect)
      if inner_node_and_methods
        inner_node_and_methods[:inner_methods].size < 2 ||
          inner_node_and_methods[:inner_methods] == '\t' ||
          inner_node_and_methods[:inner_methods] == '\n'
      else
        true
      end
    end

    def self.reject_unwanted_nodes(root_node)
      return if root_node.elements.nil?

      root_node.elements.delete_if(&REJECT_TEST)
      root_node.elements.each { |node| self.reject_unwanted_nodes(node) }
    end

    # ---------------------
    # The following methods were taken and adapted from the treetop gem:

    def self.node_as_dot(node, io)
      if (node_text = node.text_value.size > MAX_NODETEXT_LEN)
        "#{node.text_value[0..MAX_NODETEXT_LEN]}..."
      else
        node.text_value
      end
      io.puts "node#{node.dot_id} [label=\"'#{node_text}'\"];"
    end

    def self.node_to_node_dot(first_node, second_node, io)
      io.puts "node#{first_node.dot_id} -> node#{second_node.dot_id};"
    end

    def self.output_dot_to_max_levels(tree, io, level = 1)
      return if level > MAX_DOT_LEVEL

      node_as_dot(tree, io)

      return unless tree.nonterminal?

      tree.elements.each do |child_element|
        node_to_node_dot(tree, child_element, io) unless level == MAX_DOT_LEVEL
        output_dot_to_max_levels(child_element, io, level + 1)
      end
    end

    def self.write_dot(tree, fname)
      File.open(fname + '.dot', 'w') do |file|
        file.puts 'digraph G {'
        output_dot_to_max_levels(tree, file)
        file.puts '}'
      end
    end

  end

end
