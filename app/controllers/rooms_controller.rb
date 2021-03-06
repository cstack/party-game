class RoomsController < ApplicationController
  # GET /rooms or /rooms.json
  def index
    @rooms = Room.all
  end

  # GET /rooms/1 or /rooms/1.json
  def show
    @room = Room.find(params[:id]).from_perspective_of(current_user)
    room_user = RoomUser.find_or_initialize_by(user: current_user, room: @room)
    if room_user.new_record?
      @not_yet_joined = true
    end
  end

  # GET /rooms/new
  def new
    @room = Room.new
  end

  # GET /rooms/1/edit
  def edit
  end

  def start_game
    @room = Room.find(params[:room_id])
    @room.new_game!(template: params[:template])
    helpers.broadcast_game_start(room: @room, current_user: current_user)
    room = @room.from_perspective_of(current_user)
    render turbo_stream: turbo_stream.replace("room_#{room.id}", partial: "rooms/room.html.erb", locals: { room: room })
  end

  def finish_game
    @room = Room.find(params[:room_id])
    @room.finish_game!
    helpers.broadcast_game_finish(room: @room)
    room = @room.from_perspective_of(current_user)
    render turbo_stream: turbo_stream.replace("room_#{room.id}", partial: "rooms/room.html.erb", locals: { room: room })
  end

  def join
    @room = Room.find(params[:room_id])
    room_user = @room.room_users.find_or_initialize_by(user: current_user)
    if room_user.new_record?
      room_user.save
      helpers.broadcast_user_joined_room(user: current_user, room: @room)
    end
    room = @room.from_perspective_of(current_user)
    render turbo_stream: turbo_stream.replace("room_#{room.id}", partial: "rooms/room.html.erb", locals: { room: room })
  end

  def test_broadcast
    @room = Room.find(params[:room_id])
    @room.from_perspective_of(current_user).broadcast_replace_to "room_#{@room.id}_user_#{current_user.id}"
  end

  # POST /rooms or /rooms.json
  def create
    @room = Room.new
    @room.save
    room_user = RoomUser.find_or_create_by(user: current_user, room: @room)
    redirect_to @room
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
