module ApplicationHelper
  def title(*parts)
    unless parts.empty?
      content_for :title do
        (parts << "Ticketee").join(" - ")
      end
    end
  end

  def someName
    content_for :someName do
      "1111111111111111111111111111"
    end
  end
end
