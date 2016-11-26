defmodule OData.Query do

  @moduledoc """
  Query helpers for OData services.
  """

  alias __MODULE__

  defstruct service_root: nil,
    entity: nil,
    top: nil,
    skip: nil

  @type t :: %__MODULE__{}
  @default_service_root "odata"

  @doc """
  Builds a query for an OData source.
  """
  @spec build(String.t) :: Query.t
  @spec build(String.t, String.t) :: Query.t
  def build(entity), do: build(@default_service_root, entity)
  def build(service_root, entity) do
    struct(__MODULE__, %{service_root: service_root, entity: entity})
  end

  @doc """
  Sets the query limit.
  """
  @spec top(Query.t, integer) :: Query.t
  def top(query, limit) do
    Map.merge(query, %{top: limit})
  end

  @doc """
  Sets the query offset.
  """
  @spec skip(Query.t, integer) :: Query.t
  def skip(query, offset) do
    Map.merge(query, %{skip: offset})
  end

end
