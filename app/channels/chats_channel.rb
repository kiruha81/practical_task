class ChatChannel < ApplicationCable::Channel
  def subscribed
    # WebSocketのチャンネル設定
    #   チャンネル名のroom_idは、chats_channel.jsで生成している。
    stream_from "chats_channel_#{params['room_id']}"
  end

  def unsubscribed; end

  # dataの追加
  def speak(data)
    # Chatにデータを保存
    Chat.create(
      user_id: current_user.id,
      room_id: params['room_id'],
      message: data['message']
    )

    # 部分テンプレートをWebSocket経由で送り出す。
    #   render_messageで部分テンプレートに文字を埋め込みmessageとして送り出している。
    ActionCable.server.broadcast "chats_channel_#{params['room_id']}", message: render_message(data)
  end

  private

  def render_message(data)
    # renderではなくrendererに注意してください
    #   rendererは、コントローラの制約を受けずに任意のビューテンプレートをレンダリングします
    ApplicationController.renderer.render(partial: 'chats/message', locals: { message: data, current_user: current_user })
  end
end
