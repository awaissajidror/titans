WEEK_DROPDOWN  = %w[All 1st 2nd 3rd 4th]
CURRENT_MONTH  = Time.zone.now.strftime("%B")
MONTH_DROPDOWN = Date::MONTHNAMES.slice(1..-1)
DAYS_OF_WEEK   = Date::DAYNAMES.drop_while { |day| day != 'Monday' }.take_while { |day| day != 'Sunday' }
