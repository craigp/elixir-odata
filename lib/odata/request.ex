defmodule OData.Request do

  @moduledoc """
  Build requests for OData APIs.
  """

  alias __MODULE__
  alias OData.Response

  defstruct url: nil,
    query: nil,
    headers: %{"content-type" => "application/json"}

  @type t :: %__MODULE__{}

  @doc """
  Builds a request from a query and URL.
  """
  def build(query, url) do
    %Request{url: url, query: query}
  end

  @doc """
  Adds HTTP headers to the request.
  """
  @spec add_header(map, {String.t, String.t}) :: Request.t
  def add_header(%{headers: headers} = request, {key, val}) do
    %Request{request | headers: Map.put(headers, key, val)}
  end

  @doc """
  Calls the OData API.
  """
  @spec call(Request.t) :: {atom, String.t} | {atom, Response.t}
  def call(request) do
    OData.HTTP.get(request)
  end

end
