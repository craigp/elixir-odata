defmodule OData do

  @moduledoc """
  See the README.
  """

  use Application

  @doc false
  def start(_type, _args) do
    import Supervisor.Spec, warn: false
    children = [
    ]
    opts = [strategy: :one_for_one, name: OData.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
