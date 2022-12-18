defmodule MarleyWeb.RecipeLive.Show do
  use MarleyWeb, :live_view

  alias Marley.Recipes

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:recipe, Recipes.get_recipe!(id))}
  end

  defp page_title(:show), do: "Show Recipe"
end
