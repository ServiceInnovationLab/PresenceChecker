# frozen_string_literal: true

module EligibilitiesHelper
  def success_class(value)
    if value
      'success'
    else
      'warning'
    end
  end

  def success_icon(value)
    if value
      '<i class="far fa-check"></i>'.html_safe
    else
      '<i class="far fa-times"></i>'.html_safe
    end
  end
end
