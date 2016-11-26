defmodule OData.Request do

  @moduledoc """
  Build requests for OData APIs.
  """

  alias __MODULE__

  defstruct url: nil,
    query: nil,
    headers: %{"content-type" => "application/json"}

  @type t :: %__MODULE__{}

  def build(query, url) do
    %Request{url: url, query: query}
  end

  def add_header(%{headers: headers} = request, {key, val}) do
    %Request{request | headers: Map.put(headers, key, val)}
  end

  def call(request) do
    OData.HTTP.get(request)
  end

end
