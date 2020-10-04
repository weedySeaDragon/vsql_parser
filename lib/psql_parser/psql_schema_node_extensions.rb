# frozen_string_literal: true

require 'treetop'

module PSqlSchema

  class PSqlSchemaNode < ::Treetop::Runtime::SyntaxNode
  end

  class CopyData < PSqlSchemaNode
  end

  class CopyDataLine < PSqlSchemaNode
  end


  # Most of the following are for the PSqlParser:
  #  --------------------------------------------
  # class CommentLine < ::Treetop::Runtime::SyntaxNode
  # end
  #
  #
  # class Operator < ::Treetop::Runtime::SyntaxNode
  # end
  #
  #
  # class Statement < ::Treetop::Runtime::SyntaxNode
  # end
  #
  # class SelectStatement < ::Treetop::Runtime::SyntaxNode
  #   def expressions
  #     Helpers.find_elements(self, SelectExpression)
  #   end
  # end
  #
  # class SelectExpression < ::Treetop::Runtime::SyntaxNode
  #   def expression_sql
  #   end
  #
  #   def alias_node
  #     @alias_node ||= Helpers.find_elements(self, Alias, Query).first
  #   end
  #
  #
  #   def root_nodes
  #     elements[0].elements.select { |e| !e.text_value.empty? }
  #   end
  #
  #
  #   def name
  #     case
  #       when alias_node
  #         alias_node.text_value
  #       when root_nodes.length == 1 && root_nodes.first.is_a?(Function)
  #         root_nodes.first.name
  #       when root_nodes.length == 1 && root_nodes.first.is_a?(FieldRef)
  #         element =
  #           Helpers.find_elements(self, FieldGlob).last ||
  #             Helpers.find_elements(self, Name).last
  #         element.text_value
  #       else
  #         "?column?"
  #     end
  #   end
  # end
  #
  # class JoinStatement < ::Treetop::Runtime::SyntaxNode
  # end
  #
  # class WhereStatement < ::Treetop::Runtime::SyntaxNode
  # end
  #
  # class StatementClause < ::Treetop::Runtime::SyntaxNode
  # end
  #
  # class HavingClause < StatementClause
  # end
  #
  # class WindowStatement < StatementClause
  # end
  #
  # class GroupByClause < StatementClause
  # end
  #
  # class OrderByClause < StatementClause
  # end
  #
  # class Name < ::Treetop::Runtime::SyntaxNode
  # end
  #
  # class FieldRef < ::Treetop::Runtime::SyntaxNode
  # end
  #
  # class TablePart < ::Treetop::Runtime::SyntaxNode
  # end
  #
  # class FieldGlob < ::Treetop::Runtime::SyntaxNode
  # end
  #
  # class Alias < ::Treetop::Runtime::SyntaxNode
  # end
  #
  # class Function < ::Treetop::Runtime::SyntaxNode
  #   def name
  #     elements[0].text_value
  #   end
  # end
  #
  # class Entity < ::Treetop::Runtime::SyntaxNode
  #   # def to_array
  #   #   return self.elements[0].to_array
  #   # end
  # end
  #
  # class QuotedEntity < Entity
  # end
  #
  # class Query < ::Treetop::Runtime::SyntaxNode
  #   # def to_array
  #   #   return self.elements.map {|x| x.to_array}
  #   # end
  #   # def select_statement
  #   #   elements.detect { |e| e.is_a?(SelectStatement) }
  #   # end
  # end
  #
  #  END (Most of the following are for the PSqlParser)
  #  --------------------------------------------

  class DDLStatement < ::Treetop::Runtime::SyntaxNode
  end

  class CreateTable < DDLStatement
  end

  class AlterTable < DDLStatement
  end

  class GrantOrRevokeStatement < DDLStatement
  end

  class SetConfigParamStatement < DDLStatement
  end

  class CommentOnStatement < DDLStatement
  end

  class CreateSequence < DDLStatement
  end

  class AlterSequence < DDLStatement
  end

  class GrantOrRevokeStatement < DDLStatement
  end


  # class TableScope < ::Treetop::Runtime::SyntaxNode
  # end
  #
  #
  # class OptionalSchemaTableName < ::Treetop::Runtime::SyntaxNode
  # end
  #
  # class ColumnSpecification < ::Treetop::Runtime::SyntaxNode
  # end
  #
  # class ColumnName < ::Treetop::Runtime::SyntaxNode
  # end
  #
  # class ColumnCollateClause < ::Treetop::Runtime::SyntaxNode
  # end
  #
  # class ColumnConstraint < ::Treetop::Runtime::SyntaxNode
  # end
  #
  # class ConstraintDefinition < ::Treetop::Runtime::SyntaxNode
  # end
  #
  # class DeferrableClause < ::Treetop::Runtime::SyntaxNode
  # end
  #

  module ImmediateClause
  end


  class NullOrNotClause < ::Treetop::Runtime::SyntaxNode
  end
  #
  # class DefaultExpression < ::Treetop::Runtime::SyntaxNode
  # end
  #
  # class PrimaryKeyDefinition < ::Treetop::Runtime::SyntaxNode
  # end
  #
  # class UniqueDefinition < ::Treetop::Runtime::SyntaxNode
  # end
  #
  # class CheckExpression < ::Treetop::Runtime::SyntaxNode
  # end
  #
  # class ColumnConstraint < ::Treetop::Runtime::SyntaxNode
  # end
  #
  # class ReferencesDefinition < ::Treetop::Runtime::SyntaxNode
  # end
  #
  # class ColumnsInParentheses < ::Treetop::Runtime::SyntaxNode
  # end
  #
  # class UsingIndexTablespaceParameters < ::Treetop::Runtime::SyntaxNode
  # end
  #
  # class ListSeparator < ::Treetop::Runtime::SyntaxNode
  # end
  #
  # class ItemsList < ::Treetop::Runtime::SyntaxNode
  # end
  #
  # class RoleNames < ItemsList
  # end
  #
  # class RoleSpecifications < ItemsList
  # end
  #
  # class RoleSpecification < ::Treetop::Runtime::SyntaxNode
  # end
  #
  class ItemName < ::Treetop::Runtime::SyntaxNode
  end

  class TableName < ItemName
  end

  class SchemaName < ItemName
  end
  #
  # class RoleName < ItemName
  # end
  #
  # class SessionLocalScope < ::Treetop::Runtime::SyntaxNode
  # end
  #
  # class ConfigParameter < ItemName
  # end
  #
  # class CommentText < ItemName
  # end
  #
  # class CommentTargetAggregate < ::Treetop::Runtime::SyntaxNode
  # end
  #
  # class AggregateName < ItemName
  # end
  #
  # class AggregateMode < ::Treetop::Runtime::SyntaxNode
  # end
  #
  # class AggregateType < ::Treetop::Runtime::SyntaxNode
  # end
  #
  # class AggregateTypes < ItemsList
  # end
  #
  # class AggregateModeNameTypesClause < ::Treetop::Runtime::SyntaxNode
  # end
  #
  # class AggregateSignature < ::Treetop::Runtime::SyntaxNode
  # end
  #
  # class ProceduralLanguageCommentTarget < ItemName
  # end
  #
  # class CommentTargetOnObjectClause < ::Treetop::Runtime::SyntaxNode
  # end
  #
  # class CommentTargetObjectKeyword < ::Treetop::Runtime::SyntaxNode
  # end
  #
  # class CommentTargetObjectName < ItemName
  # end
  #
  # class SequenceClause < ::Treetop::Runtime::SyntaxNode
  # end
  #
  # class AlterSequenceRenameClause < ::Treetop::Runtime::SyntaxNode
  # end
  #
  # class AlterSequenceChangeOwnerClause < ::Treetop::Runtime::SyntaxNode
  # end
  #
  # class AlterSequenceChangeSchemaClause < ::Treetop::Runtime::SyntaxNode
  # end
  #
  # class AlterSequenceClause < ::Treetop::Runtime::SyntaxNode
  # end
  #
  # class SequenceName < ItemName
  # end
  #
  # class IfNotExistsClause < ::Treetop::Runtime::SyntaxNode
  # end
  #
  # class StartsWithClause < ::Treetop::Runtime::SyntaxNode
  # end
  #
  # class IncrementClause < ::Treetop::Runtime::SyntaxNode
  # end
  #
  # class MinValueClause < ::Treetop::Runtime::SyntaxNode
  # end
  #
  # class MaxValueClause < ::Treetop::Runtime::SyntaxNode
  # end
  #
  # class CacheClause < ::Treetop::Runtime::SyntaxNode
  # end
  #
  # class CycleClause < ::Treetop::Runtime::SyntaxNode
  # end
  #
  # class OwnedByClause < ::Treetop::Runtime::SyntaxNode
  # end
  #
  # class CacheName < ItemName
  # end
  #
  # class OwnerName < ::Treetop::Runtime::SyntaxNode
  # end
  #
  # class SequenceTempTimeScope < ::Treetop::Runtime::SyntaxNode
  # end
  #
  # class PosNegInteger < ::Treetop::Runtime::SyntaxNode
  # end
  #
  # class Terminal < ::Treetop::Runtime::SyntaxNode
  # end
  #
  # class WordBoundary < Terminal
  # end
  #
  # class Space < Terminal
  # end
  #
  # class SQLKeyword < ::Treetop::Runtime::SyntaxNode
  # end
  #
  # class DataType < ::Treetop::Runtime::SyntaxNode
  # end
  #
  # class BitVaryingType < DataType
  # end
  #
  # class CharacterType < DataType
  # end
  #
  # class VarCharType < DataType
  # end
  #
  # class IntegerInParentheses < Terminal
  # end
  #
  # class NumericType < DataType
  # end
  #
  # class FloatType < DataType
  # end
  #
  # class IntervalType < DataType
  # end
  #
  # class NextValFunctionCall < ::Treetop::Runtime::SyntaxNode
  # end
  #
  # class TimestampType < DataType
  # end
  #
  # class WithOrWithoutTimeZoneClause < ::Treetop::Runtime::SyntaxNode
  # end
end
