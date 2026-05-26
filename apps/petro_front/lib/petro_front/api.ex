defmodule PetroFront.Api do
  @moduledoc """
  В данном модуле описаны REST API методы
  """
  use Plug.Router
  require Logger

  plug(:match)
  plug(:dispatch)

  ### метод для инициализации супервизором.
  def child_spec(_args) do
    Plug.Cowboy.child_spec(
      scheme: :http,
      options: [
        port: Application.fetch_env!(:petro_front, :http_port)
      ],
      plug: __MODULE__
    )
  end

  get "/entry" do
    conn = Plug.Conn.fetch_query_params(conn)
    Logger.debug("fetch_query_params: #{inspect(conn)}")

    # отправка ответа
    conn
    |> Plug.Conn.put_resp_content_type("text/plain")
    |> Plug.Conn.send_resp(200, "OK")
  end

  post "/entry" do
    conn = Plug.Conn.fetch_query_params(conn)
    Logger.debug("fetch_query_params: #{inspect(conn)}")

    # отправка ответа
    conn
    |> Plug.Conn.put_resp_content_type("text/plain")
    |> Plug.Conn.send_resp(200, "OK")
  end

  delete "/entry" do
    conn = Plug.Conn.fetch_query_params(conn)
    Logger.debug("fetch_query_params: #{inspect(conn)}")

    # отправка ответа
    conn
    |> Plug.Conn.put_resp_content_type("text/plain")
    |> Plug.Conn.send_resp(200, "OK")
  end

  match _ do
    Logger.error("defaut api handler: #{inspect(conn)}")
    send_resp(conn, 404, "Ой!")
  end
end
