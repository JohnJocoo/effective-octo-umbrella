defmodule Marley.RecipesData do

  import Contentful.Query
  alias Contentful.Delivery.Entries

  alias Marley.Recipe

  @spec preview_get_all() :: [%Recipe{}]
  def preview_get_all() do
    {:ok, recipe_entries, total: _} =
      Entries
      |> content_type("recipe")
      |> limit(100)
      |> fetch_all

    {recipes, _} =
      recipe_entries
      |> Enum.map(&entry_to_recipe/1)
      |> Enum.unzip()

    recipes
  end

  @spec fetch_by_id!(String.t()) :: %Recipe{}
  def fetch_by_id!(id) do
    {:ok, [recipe_entry], total: _} =
      Entries
      |> content_type("recipe")
      |> by(id: id)
      |> fetch_all

    {recipe, %{author_id: author_id, tag_ids: tag_ids}} = entry_to_recipe(recipe_entry)

    author_entry =
      if author_id != nil do
        result =
          Entries
          |> content_type("chef")
          |> by(id: id)
          |> include(1)
          |> fetch_all

        case result do
          {:ok, [author_entry], total: _} -> author_entry
          {:ok, [], total: _} -> nil
        end
      else
        nil
      end

    {:ok, tags_entries, total: _} =
      Entries
      |> content_type("tag")
      |> by(id: [in: tag_ids])
      |> include(1)
      |> fetch_all

    recipe
    |> recipe_set_author(author_entry)
    |> recipe_set_tags(tags_entries)
  end

  defp entry_to_recipe(%Contentful.Entry{assets: assets, fields: fields, sys: %Contentful.SysData{id: id}}) do
    image_id = get_image_id(fields)
    recipe = %Recipe{
      id: id,
      title: Map.fetch!(fields, "title"),
      description: Map.fetch!(fields, "description"),
      chef_name: nil,
      image_url: get_image_url_from_assets(assets, image_id)
    }
    {recipe, %{author_id: get_author_id(fields), tag_ids: get_tag_ids(fields)}}
  end

  defp recipe_set_author(%Recipe{} = recipe, %Contentful.Entry{fields: %{"name" => name}}) do
    %Recipe{recipe | chef_name: name}
  end

  defp recipe_set_author(%Recipe{} = recipe, nil), do: recipe

  defp recipe_set_tags(%Recipe{} = recipe, tag_entries) do
    tags = Enum.map(tag_entries, fn %Contentful.Entry{fields: %{"name" => tag}} -> tag end)
    %Recipe{recipe | tags: tags}
  end

  defp get_image_id(%{"photo" => photo}) do
    %{"sys" => %{
      "linkType" => "Asset",
      "type" => "Link",
      "id" => image_id
    }} = photo
    image_id
  end

  defp get_image_id(_), do: nil

  defp get_author_id(%{"chef" => author}) do
    %{"sys" => %{
      "linkType" => "Entry",
      "type" => "Link",
      "id" => author_id
    }} = author
    author_id
  end

  defp get_author_id(_), do: nil

  defp get_tag_ids(%{"tags" => tags}) do
    Enum.map(tags, fn tag ->
      %{"sys" => %{
        "linkType" => "Entry",
        "type" => "Link",
        "id" => tag_id
      }} = tag
      tag_id
    end)
  end

  defp get_tag_ids(_), do: []

  defp get_image_url_from_assets(assets, id) do
    assets
    |> Enum.find(fn
      %Contentful.Asset{sys: %Contentful.SysData{id: ^id}} -> true
      _ -> false
    end)
    |> then(fn %Contentful.Asset{fields: %Contentful.Asset.Fields{file: %{url: url}}} -> url end)
    |> URI.to_string()
  end

  defp get_image_url_from_assets(_, nil), do: nil
end
