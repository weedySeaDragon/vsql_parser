# frozen_string_literal: true

require 'treetop'

module PSqlSchema

  class PSqlSchemaNode < Treetop::Runtime::SyntaxNode
  end

  class CopyData < PSqlSchemaNode
  end

  class CopyDataLine < PSqlSchemaNode
  end


  class DDLStatement <Treetop::Runtime::SyntaxNode
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


  # class TableScope < Treetop::Runtime::SyntaxNode
  # end
  #
  #
  # class OptionalSchemaTableName <Treetop::Runtime::SyntaxNode
  # end
  #
  # class ColumnSpecification < Treetop::Runtime::SyntaxNode
  # end
  #
  # class ColumnName <Treetop::Runtime::SyntaxNode
  # end
  #
  # class ColumnCollateClause <Treetop::Runtime::SyntaxNode
  # end
  #
  # class ColumnConstraint <Treetop::Runtime::SyntaxNode
  # end
  #
  # class ConstraintDefinition <Treetop::Runtime::SyntaxNode
  # end
  #
  # class DeferrableClause <Treetop::Runtime::SyntaxNode
  # end
  #

  module ImmediateClause
  end


  class NullOrNotClause < Treetop::Runtime::SyntaxNode
  end
  #
  # class DefaultExpression <Treetop::Runtime::SyntaxNode
  # end
  #
  # class PrimaryKeyDefinition <Treetop::Runtime::SyntaxNode
  # end
  #
  # class UniqueDefinition <Treetop::Runtime::SyntaxNode
  # end
  #
  # class CheckExpression <Treetop::Runtime::SyntaxNode
  # end
  #
  # class ColumnConstraint <Treetop::Runtime::SyntaxNode
  # end
  #
  # class ReferencesDefinition <Treetop::Runtime::SyntaxNode
  # end
  #
  # class ColumnsInParentheses <Treetop::Runtime::SyntaxNode
  # end
  #
  # class UsingIndexTablespaceParameters <Treetop::Runtime::SyntaxNode
  # end
  #
  # class ListSeparator <Treetop::Runtime::SyntaxNode
  # end
  #
  # class ItemsList <Treetop::Runtime::SyntaxNode
  # end
  #
  # class RoleNames < ItemsList
  # end
  #
  # class RoleSpecifications < ItemsList
  # end
  #
  # class RoleSpecification <Treetop::Runtime::SyntaxNode
  # end
  #
  class ItemName < Treetop::Runtime::SyntaxNode
  end

  class TableName < ItemName
  end

  class SchemaName < ItemName
  end
  #
  # class RoleName < ItemName
  # end
  #
  # class SessionLocalScope <Treetop::Runtime::SyntaxNode
  # end
  #
  # class ConfigParameter < ItemName
  # end
  #
  # class CommentText < ItemName
  # end
  #
  # class CommentTargetAggregate <Treetop::Runtime::SyntaxNode
  # end
  #
  # class AggregateName < ItemName
  # end
  #
  # class AggregateMode <Treetop::Runtime::SyntaxNode
  # end
  #
  # class AggregateType <Treetop::Runtime::SyntaxNode
  # end
  #
  # class AggregateTypes < ItemsList
  # end
  #
  # class AggregateModeNameTypesClause <Treetop::Runtime::SyntaxNode
  # end
  #
  # class AggregateSignature <Treetop::Runtime::SyntaxNode
  # end
  #
  # class ProceduralLanguageCommentTarget < ItemName
  # end
  #
  # class CommentTargetOnObjectClause <Treetop::Runtime::SyntaxNode
  # end
  #
  # class CommentTargetObjectKeyword <Treetop::Runtime::SyntaxNode
  # end
  #
  # class CommentTargetObjectName < ItemName
  # end
  #
  # class SequenceClause <Treetop::Runtime::SyntaxNode
  # end
  #
  # class AlterSequenceRenameClause <Treetop::Runtime::SyntaxNode
  # end
  #
  # class AlterSequenceChangeOwnerClause <Treetop::Runtime::SyntaxNode
  # end
  #
  # class AlterSequenceChangeSchemaClause <Treetop::Runtime::SyntaxNode
  # end
  #
  # class AlterSequenceClause <Treetop::Runtime::SyntaxNode
  # end
  #
  # class SequenceName < ItemName
  # end
  #
  # class IfNotExistsClause <Treetop::Runtime::SyntaxNode
  # end
  #
  # class StartsWithClause <Treetop::Runtime::SyntaxNode
  # end
  #
  # class IncrementClause <Treetop::Runtime::SyntaxNode
  # end
  #
  # class MinValueClause <Treetop::Runtime::SyntaxNode
  # end
  #
  # class MaxValueClause <Treetop::Runtime::SyntaxNode
  # end
  #
  # class CacheClause <Treetop::Runtime::SyntaxNode
  # end
  #
  # class CycleClause <Treetop::Runtime::SyntaxNode
  # end
  #
  # class OwnedByClause <Treetop::Runtime::SyntaxNode
  # end
  #
  # class CacheName < ItemName
  # end
  #
  # class OwnerName <Treetop::Runtime::SyntaxNode
  # end
  #
  # class SequenceTempTimeScope <Treetop::Runtime::SyntaxNode
  # end
  #
  # class PosNegInteger <Treetop::Runtime::SyntaxNode
  # end
  #
  # class Terminal <Treetop::Runtime::SyntaxNode
  # end
  #
  # class WordBoundary < Terminal
  # end
  #
  # class Space < Terminal
  # end
  #
  # class SQLKeyword <Treetop::Runtime::SyntaxNode
  # end
  #
  # class DataType <Treetop::Runtime::SyntaxNode
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
  # class NextValFunctionCall <Treetop::Runtime::SyntaxNode
  # end
  #
  # class TimestampType < DataType
  # end
  #
  # class WithOrWithoutTimeZoneClause <Treetop::Runtime::SyntaxNode
  # end
end
