require 'treetop'
require_relative './psql_node_extensions'


class PsqlParser::Parser

  PSQLPARSER_BASE_PATH ||= File.expand_path(__dir__)
  PSQL_GRAMMER_FN = 'psql_parser.treetop'
  FILE_GRAMMER_FN = 'psql-schema_parser.treetop'

  MAX_DOT_LEVEL = 4

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


  def self.parse_schema(sql, show_tree: true,
                        cleanup_tree: false,
                        dot_file: false)
    parse(sql, grammarparser: schema_parser,
          show_tree: show_tree,
          cleanup_tree: cleanup_tree,
          dot_file: dot_file)
  end


  def self.parse(sql, grammarparser: parser,
                 show_tree: false,
                 cleanup_tree: false,
                 dot_file: false)

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

    result_tree = tree
    result_tree = reject_tree_terminals(tree) if cleanup_tree

    puts result_tree.inspect if show_tree

    if dot_file
      dot_fname = File.join(__dir__, "parser-#{Time.now.to_i}")
      if result_tree.is_a? Array
        result_tree.each_with_index { |t, i| write_dot(t, "#{dot_fname}-#{i}") }
      else
        write_dot(result_tree, "#{dot_fname}-0")
      end
    end

    result_tree
  end


  def self.parser_error_details(parsed_str, parser)
    fail_index = parser.max_terminal_failure_index
    "\n fail_index = #{fail_index}\n\n" +
      ((fail_index > 0) ? parsed_str[0..(fail_index - 1)] : "") + ':' +
      parsed_str[(fail_index)..-1] +
      "\n\n"
  end


  # NOISY_NAMES = [].freeze
  # NOISY_NAMES = ['Treetop::Runtime::SyntaxNode', 'PSql::Space'].freeze

  # REJECT_TEST = lambda do |node|
  #   em = node.extension_modules
  #   interesting_methods = node.methods - [em.last ? em.last.methods : nil] - node.class.instance_methods
  #   interesting_methods.empty?
  # end

  # reject a node if
  #   there are no 'inner methods' (which are names of rules in the grammar file)
  #    == the length of the String for the node is 1 or 0 (empty)
  #      -- which are usually literals
  #        (e.g. letters, numbers, punctuation, space, or empty)
  REJECT_TEST = lambda do |node|
    inspect_matcher = /SyntaxNode(?<inner_node>\+\w+)?[^"]+"(?<inner_methods>[^"]*)"/
    inner_node_and_methods = inspect_matcher.match(node.inspect)
    if inner_node_and_methods
      inner_node_and_methods[:inner_methods].size < 2 || inner_node_and_methods[:inner_methods] == '\t' || inner_node_and_methods[:inner_methods] == '\n'
    else
      true
    end
  end


  def self.reject_tree_terminals(root_node)
    return if (root_node.elements.nil?)

    root_node.elements.delete_if &REJECT_TEST
    root_node.elements.each { |node| self.reject_tree_terminals(node) }
  end


  MAX_NODETEXT_LEN = 1000

  def self.node_as_dot(node, io)
    node_text = node.text_value.size > MAX_NODETEXT_LEN ? "#{node.text_value[0..MAX_NODETEXT_LEN]}..." : node.text_value
    io.puts "node#{node.dot_id} [label=\"'#{node_text}'\"];"
  end


  def self.node_to_node_dot(first_node, second_node, io)
    io.puts "node#{first_node.dot_id} -> node#{second_node.dot_id};"
  end


  def self.output_dot_to_max_levels(tree, io, level = 1)
    return if level > MAX_DOT_LEVEL

    node_as_dot(tree, io)

    if tree.nonterminal? then
      tree.elements.each do |child_element|
        node_to_node_dot(tree, child_element, io) unless level == MAX_DOT_LEVEL
        output_dot_to_max_levels(child_element, io, level + 1)
      end
    end
  end


  def self.write_dot(tree, fname)
    File.open(fname + ".dot", "w") do
    |file|
      file.puts "digraph G {"
      output_dot_to_max_levels(tree, file)
      file.puts "}"
    end
  end

end

