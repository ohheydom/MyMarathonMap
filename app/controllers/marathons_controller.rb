class MarathonsController < ApplicationController
  before_action :signed_in_user, :correct_user
  before_action :add_zero_lambda, only: [:new, :edit]
  before_action :states, only: [:new, :edit]

  def create
    @marathon = current_user.marathons.new(marathon_params)
    respond_to do |format|
      if @marathon.save
        format.html { redirect_to current_user, notice: 'State has been added.' }
      else
        format.html { redirect_to current_user, notice: 'Sorry, something went wrong' }
      end
    end
  end

  def new
    @user = user
    @marathon = current_user.marathons.new
    @selected_state = state_id(params[:state] ? params[:state].downcase : 'al')
  end

  def edit
    @user = user
    @marathon = current_user.marathons.find(params[:id])
    @selected_state = state_id(@marathon.state.state.downcase)
    @time = TimeConverter.new(@marathon.time).seconds_to_s.split(':').map(&@add_zero_lambda)
  end

  def update
    @marathon = current_user.marathons.find(params[:id])
    respond_to do |format|
      if @marathon.update(marathon_params)
        format.html { redirect_to root_path, notice: 'Marathon was succesfully edited.' }
      else
        format.html { render action: 'edit' }
      end
    end
  end

  def destroy
    @marathon = current_user.marathons.find(params[:id])
    @marathon.destroy
    respond_to do |format|
      format.html { redirect_to root_path }
    end
  end

  def state_id(state)
    states = %w(al ak az ar ca co ct de fl ga hi id il in ia ks ky
                la me md ma mi mn ms mo mt ne nv nh nj nm ny nc nd
                oh ok or pa ri sc sd tn tx ut vt va wa wv wi wy)
    (states.find_index(state) ? states.find_index(state) : 0) + 1
  end

  def add_zero_lambda
    @add_zero_lambda = ->(s) { s.rjust(2, '0') }
  end

  def states
    @states = State.all
  end

  private

  def marathon_params
    params.require(:marathon).permit(:state_id, :city, :time, :hour, :minute, :seconds, :date_of_marathon)
  end
end
