defmodule OData.HTTP do

  @moduledoc """
  Makes HTTP requests to the OData service.
  """

  alias OData.{Request, Response}

  @doc """
  Make an HTTP GET request.
  """
  @spec get(Request.t) :: Response.t
  def get(%{url: url, headers: headers, query: %{params: params, service_root: root, entity: entity}}) do
    opts = [timeout: :infinity, recv_timeout: :infinity, ssl: [versions: [:"tlsv1.2"]]]
    params =
      params
      |> Enum.filter(fn {_, v} -> v != nil end)
      |> Enum.map(fn {k, v} -> {"$#{k}", v} end)
    "#{url}/#{root}/#{entity}?#{URI.encode_query(params)}"
    |> HTTPoison.get(headers, opts)
  end

end
