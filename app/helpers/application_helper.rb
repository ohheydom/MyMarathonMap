module ApplicationHelper
  def full_title(title)
    base_title = 'My Marathon Map'
    title.empty? ? base_title : "#{base_title} | #{title}"
  end

  def sorter(column, title = nil)
    sorter = Sorter.new(params[:sort], params[:direction])
    title ||= column.titleize
    css_class = column == sorter.column ? "current #{sorter.direction}" : nil
    direction = column == sorter.column && sorter.direction == 'asc' ? 'desc' : 'asc'
    link_to title, params.merge(sort: column, direction: direction), class: css_class
  end
end
