defmodule OdataTest do

  use ExUnit.Case

  setup do
    bypass = Bypass.open
    {:ok, people_json} = File.read("test/support/people.json")
    url = "http://localhost:#{bypass.port}/dummy"
    {:ok, %{
      bypass: bypass,
      people_json: people_json,
      url: url
    }}
  end

  test "requests a list of people", %{
    bypass: bypass,
    people_json: people_json,
    url: url
  } do
    Bypass.expect bypass, fn conn ->
      assert "/dummy/odata/People" == conn.request_path
      assert "GET" == conn.method
      assert {"content-type", "application/json"} in conn.req_headers
      Plug.Conn.resp(conn, 200, people_json)
    end
    "People"
    |> OData.build_query
    |> OData.build_request(url)
    |> OData.call
    OData.call("People", url)
  end

end
