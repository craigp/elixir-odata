defmodule OData.QueryTest do

  use ExUnit.Case
  alias OData.Query
  doctest OData.Query

  test "build a query for list of top ten people, skipping the first five" do
    %Query{
      service_root: "odata",
      entity: "People",
      params: %{
        top: 10,
        skip: 5
      }
    } =
      "People"
      |> Query.build
      |> Query.top(10)
      |> Query.skip(5)
  end

end
