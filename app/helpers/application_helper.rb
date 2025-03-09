module ApplicationHelper
  def short_date(date)
      date.strftime("%b %e, %Y")
  end
end
