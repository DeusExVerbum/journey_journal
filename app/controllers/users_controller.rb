class UsersController < ApplicationController
# before_filter :configure_sign_in_params, only: [:create]
  before_action :set_user, 
    only: [
      :show, 
      :follow_journey, :unfollow_journey,
      :follow_user, :unfollow_user
    ]

  def show
  end

  def follow_user
    @owner = User.find(params[:follow_id])
    @user.follow(@owner)
  end

  def unfollow_user
    @owner = User.find(params[:follow_id])
    @user.stop_following(@owner)
  end

  def follow_journey
    @journey = Journey.find(params[:follow_id])
    @user.follow(@journey)
  end

  def unfollow_journey
    @journey = Journey.find(params[:follow_id])
    @user.stop_following(@journey)
  end

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # You can put the params you want to permit in the empty array.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.for(:sign_in) << :attribute
  # end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:id, :follow_id)
    end
end
