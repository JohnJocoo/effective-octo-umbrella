defmodule MarleyWeb.RecipeLiveTest do
  use MarleyWeb.ConnCase
  import Phoenix.LiveViewTest
  import Marley.RecipesFixtures
  import Mock

  alias Marley.Recipe
  alias Marley.RecipesData

  @create_attrs %{chef_name: "some chef_name", description: "some description", image_url: "some image_url", tags: [], title: "some title"}
  @update_attrs %{chef_name: "some updated chef_name", description: "some updated description", image_url: "some updated image_url", tags: [], title: "some updated title"}
  @invalid_attrs %{chef_name: nil, description: nil, image_url: nil, tags: [], title: nil}

  defp create_recipe(_) do
    recipe = recipe_fixture()
    %{recipe: recipe}
  end

  describe "Index" do
    setup [:create_recipe]

    test "lists all recipes", %{conn: conn, recipe: recipe} do
      with_mock RecipesData, [preview_get_all: fn -> [recipe] end] do
        {:ok, _index_live, html} = live(conn, Routes.recipe_index_path(conn, :index))

        assert html =~ "Listing Recipes"
        assert html =~ recipe.title
      end
    end
  end

  describe "Show" do
    setup [:create_recipe]

    test "displays recipe", %{conn: conn, recipe: %Recipe{id: id} = recipe} do
      with_mock RecipesData, [fetch_by_id!: fn ^id -> recipe end] do
        {:ok, _show_live, html} = live(conn, Routes.recipe_show_path(conn, :show, recipe))

        assert html =~ "Show Recipe"
        assert html =~ recipe.title
      end
    end
  end
end
