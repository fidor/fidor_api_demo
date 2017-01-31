module ApplicationHelper
  def format_currency(amount)
    number_to_currency amount, unit: "&euro;".html_safe, format: "%n %u"
  end
end
