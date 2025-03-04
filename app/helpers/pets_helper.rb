module PetsHelper
  def underscore_to_slash(value)
    value.gsub("_", "/")
  end

  def time_difference_in_years_and_months(start_date, end_date = Date.today)
    return "Invalid dates" if start_date.blank? || end_date.blank?

    start_date, end_date = [ start_date, end_date ].sort

    years = end_date.year - start_date.year
    months = end_date.month - start_date.month

    if months.negative?
      years -= 1
      months += 12
    end

    if years.positive? && months.positive?
      "#{years} year#{'s' unless years == 1} #{months} month#{'s' unless months == 1}"
    elsif years.positive?
      "#{years} year#{'s' unless years == 1}"
    else
      "#{months} month#{'s' unless months == 1}"
    end
  end
end
