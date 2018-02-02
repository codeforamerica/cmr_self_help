class RapSheetPresenter
  def initialize(parsed_rap_sheet)
    @parsed_rap_sheet = parsed_rap_sheet
  end

  def convictions
    court_events = parsed_rap_sheet.cycles.elements.flat_map do |cycle|
      cycle.events.select do |event|
        event.class == EventGrammar::CourtEvent
      end
    end

    court_events = court_events.select do |e|
      e.counts.elements.any? {|c| c.disposition.is_a? EventGrammar::Convicted }
    end

    court_events.map do |e|
      {
        date: format_date(e),
        case_number: format_case_number(e.case_number)
      }
    end
  end

  private

  attr_reader :parsed_rap_sheet

  def format_case_number(c)
    return if c.nil?
    stripped_case_number = c.text_value.delete(' ').delete('.')
    strip_trailing_punctuation(stripped_case_number)
  end

  def format_date(e)
    Date.strptime(e.date.text_value, '%Y%m%d')
  end

  def strip_trailing_punctuation(str)
    new_str = str

    while new_str.end_with?('.', ':')
      new_str = new_str[0..-2]
    end
    new_str
  end
end
