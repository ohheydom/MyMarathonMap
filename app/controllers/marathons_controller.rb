class MarathonsController < ApplicationController
  before_action :signed_in_user, :correct_user
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
    @new_marathon = NewMarathon.new(user, params)
  end

  def edit
    @new_marathon = NewMarathon.new(user, params)
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

  def states
    @states = State.all
  end

  private

  def marathon_params
    params.require(:marathon).permit(:state_id, :city, :time, :hour, :minute, :seconds, :date_of_marathon)
  end
end
