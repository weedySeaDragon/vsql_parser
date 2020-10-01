require 'treetop'
require_relative './psql_node_extensions'


class PsqlParser::Parser

  PSQLPARSER_BASE_PATH ||= File.expand_path(__dir__)
  PSQL_GRAMMER_FN = 'psql_parser.treetop'
  FILE_GRAMMER_FN = 'psql-schema_parser.treetop'


  # This call to Treetop will create a Parser class based on the root name in the grammar file.
  grammars = [PSQL_GRAMMER_FN, FILE_GRAMMER_FN].freeze

  grammars.each { |grammarfile| Treetop.load(File.join(PSQLPARSER_BASE_PATH, grammarfile)) }

  # -------------------------------------------

  def self.parser
    @@parser ||= PSqlParser.new
  end


  def self.schema_parser
    @@parser ||= PSqlSchemaParser.new
  end


  def self.parse_schema(sql, show_tree: true)
    parse(sql, grammarparser: schema_parser, show_tree: show_tree)
  end


  def self.parse(sql, grammarparser: parser,
                 show_tree: false, remove_tree_terminals: true)
    d_sql = sql.downcase # REQUIRED!

    tree = grammarparser.parse(d_sql).tap do
      d_sql.replace(sql)
    end

    # If the AST is nil then there was an error during parsing
    # we need to report a simple error message to help the user
    if tree.nil?
      puts grammarparser.failure_reason
      puts " "
      puts parser_error_details(sql, grammarparser)
      raise Exception, grammarparser.failure_reason
    end

    if show_tree
      if remove_tree_terminals
        puts reject_tree_terminals(tree).inspect
      else
        puts tree.inspect
      end
    end

    tree
  end


  def self.parser_error_details(parsed_str, parser)
    fail_index = parser.max_terminal_failure_index
    "\n fail_index = #{fail_index}\n\n" +
      ((fail_index > 0) ? parsed_str[0..(fail_index - 1)] : "") + ':' +
      parsed_str[(fail_index)..-1] +
      "\n\n"
  end


  NOISY_NAMES = [].freeze
  # NOISY_NAMES = ['Treetop::Runtime::SyntaxNode', 'PSql::Space'].freeze


  def self.reject_tree_terminals(root_node)
    return if (root_node.elements.nil?)

    root_node.elements.delete_if { |node| NOISY_NAMES.include? node.class.name }
    root_node.elements.each { |node| self.reject_tree_terminals(node) }
  end

end

