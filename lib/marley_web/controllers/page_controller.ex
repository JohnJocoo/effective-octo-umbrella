defmodule MarleyWeb.PageController do
  use MarleyWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
