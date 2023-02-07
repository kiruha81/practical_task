class ChatsController < ApplicationController
  before_action :authenticate_user!

  def index
    @users = User.all
  end

  def show
    # チャットのターゲットユーザー情報を取得
    @user = User.find(params[:id])

    # 自分と関連づいたチャットルームを配列で取得
    rooms = current_user.user_rooms.pluck(:room_id)

    # ターゲットユーザーと自分が、関連づいたチャットルームを取得
    user_room = UserRoom.find_by(user_id: @user.id, room_id: rooms)

    if user_room.nil?
      # ターゲットユーザーと自分が、関連づいたチャットルームが「ない」場合
      # ---
      # チャットルームを生成(ルームID)
      @room = Room.create()
      # ---
      # ターゲットユーザーと自分を関連付けるチャットルームレコードを生成
      UserRoom.create(user_id: current_user.id, room_id: @room.id)
      UserRoom.create(user_id: @user.id, room_id: @room.id)
    else
      # ターゲットユーザーと自分が、関連づいたチャットルームが「ある」場合
      # ---
      # チャットルームの情報(ルームID)を返す
      @room = user_room.room
    end
  end
end
