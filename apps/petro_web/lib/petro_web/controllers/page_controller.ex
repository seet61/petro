defmodule PetroWeb.PageController do
  use PetroWeb, :controller

  def home(conn, _params) do
    render(conn, :home)
  end
end
