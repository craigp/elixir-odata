defmodule OData.Query do

  @moduledoc """
  Construct queries for OData APIs.
  """

  alias __MODULE__

  defstruct service_root: nil,
    entity: nil,
    id: nil,
    params: %{
      top: nil,
      skip: nil
    }

  @type t :: %__MODULE__{}
  @default_service_root "odata"
  @valid_params ~w(top skip expand)a

  @doc """
  Builds a query for an OData source.
  """
  @spec build(String.t) :: Query.t
  @spec build(String.t, String.t) :: Query.t
  @spec build(String.t, String.t, list) :: Query.t
  def build(entity), do: build(@default_service_root, entity)
  def build(service_root, entity), do: build(service_root, entity, [])
  def build(service_root, entity, params) do
    params = params |> Keyword.take(@valid_params) |> Enum.into(%{})
    struct(__MODULE__, %{
      service_root: service_root,
      entity: entity,
      params: params
    })
  end

  @doc """
  Sets the ID when getting a specific item.
  """
  @spec id(Query.t, any) :: Query.t
  def id(%Query{} = query, entity_id) do
    Map.put(query, :id, entity_id)
  end

  @doc """
  Sets the query limit.
  """
  @spec top(Query.t, integer) :: Query.t
  def top(%Query{} = query, limit) do
    set_params(query, top: limit)
  end

  @doc """
  Sets the query offset.
  """
  @spec skip(Query.t, integer) :: Query.t
  def skip(%Query{} = query, offset) do
    set_params(query, skip: offset)
  end

  @doc """
  Set the params for the query all at once, eg. top, skip.
  """
  @spec set_params(Query.t, Keyword.t) :: Query.t
  def set_params(%Query{params: params} = query, new_params) when is_list(new_params) do
    new_params = new_params |> Keyword.take(@valid_params) |> Enum.into(%{})
    Map.put(query, :params, Map.merge(params, new_params))
  end

end
