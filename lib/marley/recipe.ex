defmodule Marley.Recipe do

  @type t :: %__MODULE__{
    id: String.t(),
    title: String.t(),
    description: String.t(),
    chef_name: String.t(),
    image_url: String.t(),
    tags: [String.t()]
  }
  defstruct [
    :id,
    :title,
    :description,
    :chef_name,
    image_url: nil,
    tags: []
  ]

end
