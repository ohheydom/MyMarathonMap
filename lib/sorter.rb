class Sorter
  def initialize(column, direction)
    @column = column
    @direction = direction
  end

  def direction
    %w(asc desc).include?(@direction) ? @direction : 'asc'
  end

  def column
    allowed_column_names.include?(@column) ? @column : 'state_id'
  end

  def sort_string
    column + ' ' + direction
  end

  private

  def allowed_column_names
    @_allowed_column_names ||= Marathon.column_names
  end
end
