defmodule Tacos.Parser do
  @doc "Parse the given string"
  @callback parse(data :: String.t) :: any
end
