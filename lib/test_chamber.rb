# In file parser.rb
require_relative './psql_parser.rb'

module TestChamber
  module Helpers
    NORMAL_COLOR ||= 37
    def colorize(color, output)
      "\e[0;#{color}m#{output}\e[0;#{NORMAL_COLOR}m"
    end
  end

  include Helpers
  extend self

  def parse(sql, output_errors = true)
    parser = ::PSqlParser.parser
    PSqlParser.parse(sql).tap do |tree|
      # If the AST is nil then there was an error during parsing
      # we need to report a simple error message to help the user
      if tree.nil?
        output_error(sql, parser) if output_errors
        raise Exception, parser.failure_reason
      end
    end
  end

  private

  def output_error(sql, parser)
    fail_index = parser.max_terminal_failure_index
    STDERR.flush
    STDOUT.flush
    STDERR.puts( "\n" +
                 ((fail_index > 0) ? colorize(42, sql[0..(fail_index - 1)]) : "") +
                 colorize(41, sql[(fail_index)..-1]) +
                 "\n\n")

    STDERR.flush
  end

  def clean_tree(root_node)
    return if(root_node.elements.nil?)
    root_node.elements.delete_if{|node| node.class.name == "Treetop::Runtime::SyntaxNode" }
    root_node.elements.each {|node| self.clean_tree(node) }
  end

  def reload
    Object.send(:remove_const, :SqlParser) rescue nil
    Object.send(:remove_const, :Sql) rescue nil
    TestChamber.send(:remove_const, :PARSER) rescue nil

    load(File.join(PSQLPARSER_BASE_PATH, 'pql_node_extensions.rb'))
    Treetop.load(File.join(PSQLPARSER_BASE_PATH, 'psql_parser.treetop'))
    PSqlParser.extend(PSqlParserHelpers)
    load(__FILE__)
  end
end
