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
  @spec build(String.t) :: {:ok, Response.t} | {:error, any}
  def build(body) when is_binary(body) do
    case Poison.decode!(body) do
      %{
        "value" => value,
        "@odata.nextLink" => next_link,
        "@odata.context" => context
      } ->
        {:ok, %Response{value: value, next_link: next_link, context: context}}
      %{
        "value" => value,
        "@odata.context" => context
      } ->
        {:ok, %Response{value: value, context: context}}
      %{
        "@odata.context" => context
      } = entity ->
        {:ok, %Response{value: entity, context: context}}
      _ ->
        {:error, :unrecognised_response}
    end
  end

end
