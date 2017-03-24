defmodule OData do

  @moduledoc """
  See the README.
  """

  defdelegate call(request), to: OData.Request

end
