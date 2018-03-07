class ConvictionCount
  def initialize(conviction_event, count_syntax_node)
    if count_syntax_node.code_section
      @code = count_syntax_node.code_section.code.text_value
      @section = format_code_section_number(count_syntax_node)
    end
    @code_section_description = format_code_section_description(count_syntax_node)
    @severity = format_severity(count_syntax_node)
    @event = conviction_event
  end

  def inspect
    OkayPrint.new(self).exclude_ivars(:@event).inspect
  end

  attr_reader :event, :code_section_description, :severity, :code, :section

  def eligible?(user, classifier)
    classifier.new(user, self).eligible?
  end

  def potentially_eligible?(user, classifier)
    classifier.new(user, self).potentially_eligible?
  end

  def long_severity
    case severity
      when 'F'
        'felony'
      when 'M'
        'misdemeanor'
      when 'I'
        'infraction'
      else
        'unknown'
    end
  end

  def code_section
    return unless code && section
    "#{code} #{section}"
  end

  private

  def format_code_section_number(count)
    count.code_section.number.text_value.delete(' ').downcase.gsub(',', '.')
  end

  def format_code_section_description(count)
    count.code_section_description.text_value.chomp if count.code_section_description
  end

  def format_severity(count)
    if count.disposition.is_a? CountGrammar::Convicted
      if count.disposition.severity
        count.disposition.severity.text_value[0]
      end
    end
  end
end
