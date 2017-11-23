module ApplicationHelper
  def user_avatar(user)
    if user.avatar_url.present?
      user.avatar_url
    else
      asset_path 'avatar.jpg'
    end
  end

  def head(user)
    if user.head.present?
      user.head
    else
      user.head = "005a55"
    end
  end

  def fa_icon(icon_class)
    content_tag 'span', '', class: "fa fa-#{icon_class}"
  end

  def declination(number, first, second, third)
    ostatok = number % 10

    if number.to_s.split(//).size > 2
      reversed_number_array = number.to_s.reverse.split(//)
      number = reversed_number_array[1] + reversed_number_array[0]
      number = number.to_i
    end
    if number >= 11 && number <= 14
      return third
    end

    if ostatok == 1
      return first
    end

    if ostatok >= 2 && ostatok <= 4
      return second
    end

    if (ostatok > 4 && ostatok <= 9) || ostatok == 0
      return third
    end
  end
end
