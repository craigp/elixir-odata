defmodule OData.Query do

  @moduledoc """
  Construct queries for OData APIs.
  """

  alias __MODULE__

  defstruct service_root: nil,
    entity: nil,
    params: %{
      top: nil,
      skip: nil
    }

  @type t :: %__MODULE__{}
  @default_service_root "odata"

  @doc """
  Builds a query for an OData source.
  """
  @spec build(String.t) :: Query.t
  @spec build(String.t, String.t) :: Query.t
  @spec build(String.t, String.t, list) :: Query.t
  def build(entity), do: build(@default_service_root, entity)
  def build(service_root, entity), do: build(service_root, entity, [])
  def build(service_root, entity, params) do
    params = params |> Keyword.take(~w(top skip)a) |> Enum.into(%{})
    struct(__MODULE__, %{
      service_root: service_root,
      entity: entity,
      params: params
    })
  end

  @doc """
  Sets the query limit.
  """
  @spec top(Query.t, integer) :: Query.t
  def top(%Query{params: params} = query, limit) do
    Map.put(query, :params, %{params | top: limit})
  end

  @doc """
  Sets the query offset.
  """
  @spec skip(Query.t, integer) :: Query.t
  def skip(%Query{params: params} = query, offset) do
    Map.put(query, :params, %{params | skip: offset})
  end

  @doc """
  Set the params for the query all at once, eg. top, skip.
  """
  @spec set_params(Query.t, Keyword.t) :: Query.t
  def set_params(%Query{params: params} = query, new_params) when is_list(new_params) do
    new_params = new_params |> Keyword.take(~w(top skip)a) |> Enum.into(%{})
    IO.inspect new_params
    Map.put(query, :params, Map.merge(params, new_params))
  end

end
