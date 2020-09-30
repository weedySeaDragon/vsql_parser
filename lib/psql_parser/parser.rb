require 'treetop'
require_relative './psql_node_extensions'


class PsqlParser::Parser

  PSQLPARSER_BASE_PATH ||= File.expand_path(__dir__)
  PSQL_GRAMMER_FN = 'psql_parser.treetop'

  # Load the Treetop grammar from the 'sexp_parser' file, and
  # create a new instance of that parser as a class variable
  # so we don't have to re-create it every time we need to
  # parse a string

  # This call to Treetop will create a Parser class based on the root name in the grammar file.
  Treetop.load(File.join(PSQLPARSER_BASE_PATH, PSQL_GRAMMER_FN))
  @@parser = PSqlParser.new


  def self.parse(sql, show_tree: false)
    d_sql = sql.downcase # REQUIRED!

    # parser.parse(d_sql).tap do
    #   d_sql.replace(sql)
    # end

    tree = parser.parse(d_sql).tap do
      d_sql.replace(sql)
    end

    # If the AST is nil then there was an error during parsing
    # we need to report a simple error message to help the user
    if tree.nil?
      error_details = parser_error_details(sql, parser)
      puts error_details

      raise Exception, parser.failure_reason
    end

    puts remove_syntax_nodes(tree).inspect if show_tree
    tree
  end


  def self.parser
    @@parser ||= PSqlParser.new
  end


  def self.parser_error_details(parsed_str, parser)
    fail_index = parser.max_terminal_failure_index
    "\n" +
      ((fail_index > 0) ? parsed_str[0..(fail_index - 1)] : "") + ': ' +
      parsed_str[(fail_index)..-1] +
      "\n\n"
  end


  NOISY_NAMES = ['Treetop::Runtime::SyntaxNode', 'PSql::Space'].freeze

  def self.remove_syntax_nodes(root_node)
    return if (root_node.elements.nil?)

    root_node.elements.delete_if { |node| NOISY_NAMES.include? node.class.name }
    root_node.elements.each { |node| self.remove_syntax_nodes(node) }
  end

end

