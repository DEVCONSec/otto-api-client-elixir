defmodule OttoApiClientTest do
  use ExUnit.Case
  doctest OttoApiClient

  test "greets the world" do
    assert OttoApiClient.hello() == :world
  end
end
