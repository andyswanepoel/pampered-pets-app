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

  def is_authenticated?
    Current.user.present?
  end

  def is_provider?
    Current.user.roles.include?(Role.find_by(name: "provider"))
  end

  def is_customer?
    Current.user.roles.include?(Role.find_by(name: "customer"))
  end
end
