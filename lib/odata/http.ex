defmodule OData.HTTP do

  @moduledoc """
  Makes HTTP requests to the OData service.
  """

  alias OData.{Query, Response}
  @headers %{"content-type" => "application/json"}

  @doc """
  Make an HTTP GET request.
  """
  @spec get(Query.t, String.t) :: Response.t
  def get(query, url) do
    opts = [timeout: :infinity, recv_timeout: :infinity, ssl: [versions: [:"tlsv1.2"]]]
    HTTPoison.get(url, @headers, opts)
  end

end
