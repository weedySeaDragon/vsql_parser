require 'treetop'

module WholeFile

  class WholeFile < Treetop::Runtime::SyntaxNode
  end

  class BlankLine < Treetop::Runtime::SyntaxNode
  end

  class ContentLine < Treetop::Runtime::SyntaxNode
  end

  class CommentLine < Treetop::Runtime::SyntaxNode
  end

  class SN < Treetop::Runtime::SyntaxNode
  end
end
