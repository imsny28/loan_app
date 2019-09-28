module ApplicationHelper
  def error_for obj, attr_name
    render partial: 'shared/error', locals: { obj: obj, attr_name: attr_name }
  end
end
