defmodule Rumbl.UserSocket do
  use Phoenix.Socket

  alias Rumbl.Repo
  alias Rumbl.User

  @max_age 2 * 7 * 24 * 60 * 60

  ## Channels
  channel "videos:*", Rumbl.VideoChannel

  ## Transports
  transport :websocket, Phoenix.Transports.WebSocket
  # transport :longpoll, Phoenix.Transports.LongPoll

  def connect(%{"token" => token}, socket) do
    case Phoenix.Token.verify(socket, "user socket", token, max_age: @max_age) do
      {:ok, user_id} ->
        user = Repo.get!(User, user_id)
        {:ok, assign(socket, :current_user, user)}
      {:error, _reason} ->
        :error
    end
  end
  def connect(_params, _socket), do: :error

  def id(socket), do: "users_socket:#{socket.assigns.current_user.id}"
end
