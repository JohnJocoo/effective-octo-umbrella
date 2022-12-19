defmodule MarleyWeb.PageController do
  use MarleyWeb, :controller

  def index(conn, _params) do
    redirect(conn, to: "/recipes")
  end
end
