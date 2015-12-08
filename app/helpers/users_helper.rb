module UsersHelper
  def edit_marathon_link(user, marathon)
    if user == current_user
      link_to States.all.select { |a, b| b == marathon.state_id }[0][0], edit_user_marathon_path(current_user, marathon), 'data-no-turbolink' => true
    else
      States.all.select { |a, b| b == marathon.state_id }[0][0]
    end
  end

  def hours_minutes_seconds(seconds)
    TimeConverter.new(seconds).seconds_to_s
  end
end
