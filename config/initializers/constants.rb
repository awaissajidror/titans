CURRENT_MONTH  = Time.zone.now.strftime("%B")
MONTH_DROPDOWN = Date::MONTHNAMES.slice(1..-1)
WEEK_DROPDOWN  = ['1st Week', '2nd Week', '3rd Week', '4th Week']
DAYS_OF_WEEK   = Date::DAYNAMES.drop_while { |day| day != 'Monday' }.take_while { |day| day != 'Sunday' }
