class UsersController < ApplicationController
  before_action :signed_in_user, except: [:new, :create]
  before_action :correct_user, only: [:edit, :update]
  before_filter :redirect_if_signed_in, only: [:new, :create]
  helper_method :user

  def index
  end

  def show
    @marathon_records = MarathonRecords.new(user, Sorter.new(params[:sort], params[:direction]))
    gon_states(@marathon_records)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    respond_to do |format|
      if @user.save
        sign_in @user
        format.html { redirect_to @user, notice: "Welcome #{@user.username}" }
      else
        format.html { render action: 'new' }
      end
    end
  end

  def edit
    @user = user
  end

  def update
    current_password = params[:user].delete(:current_password)
    if user.authenticate(current_password)
      respond_to do |format|
        if user.update(user_params)
          format.html { redirect_to @user, notice: 'Your settings have been updated' }
        else
          format.html { render action: 'edit' }
        end
      end
    else
      redirect_to edit_user_path, notice: 'Incorrect password'
    end
  end

  private

  def user_params
    params.require(:user).permit(:username, :email, :password, :password_confirmation)
  end

  def gon_states(marathon_records)
    gon.states = marathon_records.state_total
    return if current_user == user
    current_user_states = current_user.marathons.includes(:state).map(&:state).map(&:state).uniq.map(&:downcase)
    gon.states_matching = marathon_records.state_total & current_user_states
  end
end
