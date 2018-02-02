require_relative './treetop_monkeypatches'

module EventGrammar
  class CourtEvent < Treetop::Runtime::SyntaxNode
    def case_number
      if(counts[0].is_a? CountOne)
        counts[0].case_number
      else
        nil
      end

    end
  end

  class Count < Treetop::Runtime::SyntaxNode
    def disposition
      count_content.disposition_content
    end
    end

  class Convicted < Treetop::Runtime::SyntaxNode; end

  class CountOne < Count; end
end
