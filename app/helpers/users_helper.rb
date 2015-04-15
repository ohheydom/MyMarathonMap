module UsersHelper
  def edit_marathon_link(user, marathon)
    if user == current_user
      link_to marathon.state[:state_name], edit_user_marathon_path(current_user, marathon), 'data-no-turbolink' => true
    else
      marathon.state[:state_name]
    end
  end

  def hours_minutes_seconds(seconds)
    TimeConverter.new(seconds).seconds_to_s
  end
end
