class RoomsController < ApplicationController
  # GET /rooms or /rooms.json
  def index
    @rooms = Room.all
  end

  # GET /rooms/1 or /rooms/1.json
  def show
    @room = Room.find(params[:id]).from_perspective_of(current_user)
    RoomUser.find_or_create_by(user: current_user, room: @room)
    helpers.broadcast_user_joined_room(user: current_user, room: @room)
  end

  # GET /rooms/new
  def new
    @room = Room.new
  end

  # GET /rooms/1/edit
  def edit
  end

  def start_game
    Rails.logger.info "DEBUG - start_game"
    @room = Room.find(params[:room_id])
    @room.new_game!
    other_users = @room.users - [current_user]
    Rails.logger.info "DEBUG - @room.users -> #{@room.users.map(&:id)}"
    Rails.logger.info "DEBUG - current_user -> #{current_user.id}"
    Rails.logger.info "DEBUG - other_users -> #{other_users.map(&:id)}"
    other_users.each do |user|
      Rails.logger.info "DEBUG - (Room #{@room.id}).broadcast_replace_to room_#{@room.id}_user_#{user.id}"
      @room.from_perspective_of(user).broadcast_replace_to "room_#{@room.id}_user_#{user.id}"
    end
    redirect_to @room
  end

  def test_broadcast
    @room = Room.find(params[:room_id])
    @room.from_perspective_of(current_user).broadcast_replace_to "room_#{@room.id}_user_#{current_user.id}"
  end

  # POST /rooms or /rooms.json
  def create
    @room = Room.new

    respond_to do |format|
      if @room.save
        format.html { redirect_to @room }
        format.json { render :show, status: :created, location: @room }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @room.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /rooms/1 or /rooms/1.json
  def update
    respond_to do |format|
      if @room.update(room_params)
        format.html { redirect_to @room, notice: "Room was successfully updated." }
        format.json { render :show, status: :ok, location: @room }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @room.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /rooms/1 or /rooms/1.json
  def destroy
    @room.destroy
    respond_to do |format|
      format.html { redirect_to rooms_url, notice: "Room was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_room
      @room = Room.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def room_params
      params.require(:room).permit(:name)
    end
end
