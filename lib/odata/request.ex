defmodule OData.Request do

  @moduledoc """
  Build requests for OData APIs.
  """

  alias __MODULE__

  defstruct url: nil,
    query: nil,
    headers: %{"content-type" => "application/json"}

  @type t :: %__MODULE__{}

  @doc """
  Builds a request from a query and URL.
  """
  @spec build(String.t, String.t) :: Request.t
  def build(query, url), do: %Request{url: url, query: query}

  @doc """
  Adds HTTP headers to the request.
  """
  @spec add_header(Request.t, {String.t, String.t}) :: Request.t
  def add_header(%Request{headers: headers} = request, {key, val}) do
    %Request{request | headers: Map.put(headers, key, val)}
  end

end
