module ApplicationHelper
  include Pagy::Frontend

  def title page
    if page.blank?
      I18n.t(".base")
    else
      I18n.t(".base") << " | " << page
    end
  end
end
