class RoomUsersController < ApplicationController
  before_action :set_room_user, only: %i[ show edit update destroy ]

  def edit
  end

  def update
    new_name = params.require(:room_user)[:name]
    success = @room_user.user.update(name: new_name)
    respond_to do |format|
      if success
        format.turbo_stream { render turbo_stream: turbo_stream.replace("room_user_#{@room_user.id}", partial: "room_users/room_user.html.erb", locals: { room_user: @room_user }) }
        format.html { redirect_to @room_user, notice: "Name was successfully updated." }
        format.json { render :show, status: :ok, location: @room_user }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @room_user.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_room_user
      @room_user = RoomUser.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def room_user_params
      params.require(:room_user).permit(:name)
    end
end
