defmodule OData.HTTP do

  @moduledoc """
  Makes HTTP requests to the OData service.
  """

  alias OData.{Request, Response, Query}

  @doc """
  Make an HTTP GET request.
  """
  @spec get(Request.t) :: Response.t
  def get(%Request{
    url: url,
    headers: headers,
    query: %Query{
      id: nil,
      params: params,
      service_root: root,
      entity: entity
    }
  }) do
    params
    |> Enum.count
    |> case do
      0 ->
        "#{url}/#{root}/#{entity}"
      _ ->
        params =
          params
          |> Enum.filter(fn {_, v} -> v != nil end)
          |> Enum.map(fn {k, v} -> {"$#{k}", v} end)
        "#{url}/#{root}/#{entity}?#{URI.encode_query(params)}"
    end
    |> get_url(headers)
  end

  def get(%Request{
    url: url,
    headers: headers,
    query: %Query{
      id: id,
      service_root: root,
      entity: entity
    }
  }) do
    get_url("#{url}/#{root}/#{entity}(#{id})", headers)
  end

  @spec get_url(String.t, map) :: Response.t
  defp get_url(url, headers) do
    opts = [timeout: :infinity, recv_timeout: :infinity, ssl: [versions: [:"tlsv1.2"]]]
    url
    |> HTTPoison.get(headers, opts)
    |> Response.build
  end

end
