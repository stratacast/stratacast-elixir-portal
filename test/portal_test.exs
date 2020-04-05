defmodule PortalTest do
  use ExUnit.Case
  doctest Portal

  setup do
    Portal.shoot(:blue)
    Portal.shoot(:orange)
    portal = Portal.transfer(:blue, :orange, [1, 2, 3, 4])

    {:ok, portal: portal}
  end

  test "shoot door" do
    assert is_list(Portal.Door.get(:blue))
    assert is_list(Portal.Door.get(:orange))
  end

  test "transfer data to portal on left", context do
    Portal.push_right(context[:portal])
    IO.inspect(length(Portal.Door.get(:orange)), label: "Length of orange portal")
    assert length(Portal.Door.get(:orange)) > 0
  end

  test "tranfer data back to the left", context do
    Portal.push_right(context[:portal])
    assert length(Portal.Door.get(:orange)) > 0

    Enum.each(Portal.Door.get(:orange), fn _x -> Portal.push_left(context[:portal]) end)
    assert length(Portal.Door.get(:orange)) == 0
  end
end
