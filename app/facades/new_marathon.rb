class NewMarathon
  def initialize(user, params)
    @user = user
    @params = params
  end

  def current_user
    @user
  end

  def marathon
    @params.key?(:id) ? @user.marathons.find(@params[:id]) : @user.marathons.new
  end

  def selected_state
    return state_id(marathon.state.state.downcase) if @params.key?(:id)
    state_id(@params[:state] ? @params[:state].downcase : 'al')
  end

  def time
    TimeConverter.new(marathon.time || 0).seconds_to_s.split(':').map(&add_zero_lambda)
  end

  def add_zero_lambda
    ->(s) { s.rjust(2, '0') }
  end

  def state_id(state)
    states = %w(al ak az ar ca co ct de fl ga hi id il in ia ks ky
                la me md ma mi mn ms mo mt ne nv nh nj nm ny nc nd
                oh ok or pa ri sc sd tn tx ut vt va wa wv wi wy)
    (states.find_index(state) ? states.find_index(state) : 0) + 1
  end
end
