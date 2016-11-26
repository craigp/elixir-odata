defmodule OData.Response do

  @moduledoc """
  An OData API query response.
  """

  alias __MODULE__

  defstruct raw: nil,
    value: nil,
    context: nil,
    next_link: nil

  @type t :: %__MODULE__{}

  @doc """
  Build a response from an HTTP response.
  """
  @spec build({atom, HTTPoison.Response.t}) :: Response.t
  def build({:ok, %HTTPoison.Response{body: body}}) do
    case Poison.decode!(body) do
      %{"value" => value, "@odata.nextLink" => next_link, "@odata.context" => context} ->
        {:ok, %Response{value: value, next_link: next_link, context: context}}
      %{"value" => value, "@odata.context" => context} ->
        {:ok, %Response{value: value, context: context}}
      %{"@odata.context" => context} = entity ->
        {:ok, %Response{value: entity, context: context}}
    end
  end

  def build({:error, %HTTPoison.Error{reason: reason}}) do
    {:error, reason}
  end

end
