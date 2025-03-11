module ApplicationHelper
  def list_items(list)
    if list.length < 3
      list.join(" and ")
    else
      "#{list[0...-1].join(", ")}, and #{list[-1]}"
    end
  end

  def short_date(date)
      date.strftime("%b %e, %Y")
  end
end
