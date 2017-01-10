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
    |> build_url(url, entity, root)
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

  @spec build_url(map, String.t, String.t, String.t) :: String.t
  defp build_url(params, url, entity, root)
  when is_map(params)
  and is_binary(url)
  and is_binary(entity)
  and is_binary(root) do
    if Enum.empty?(params) do
      "#{url}/#{root}/#{entity}"
    else
      "#{url}/#{root}/#{entity}?#{URI.encode_query(map_params(params))}"
    end
  end

  @spec map_params(map) :: map
  def map_params(params) do
    params
    |> Enum.filter(fn {_, v} -> v != nil end)
    |> Enum.map(fn {k, v} -> {"$#{k}", v} end)
  end

  @spec get_url(String.t, map) :: Response.t
  defp get_url(url, headers) do
    opts = [timeout: :infinity, recv_timeout: :infinity, ssl: [versions: [:"tlsv1.2"]]]
    url
    |> HTTPoison.get(headers, opts)
    |> Response.build
  end

end
