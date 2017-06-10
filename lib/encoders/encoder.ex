defmodule Tacos.Encoder do
  @doc "Parse the given string"
  @callback encode(data :: [any] | %{}) :: String.t
end
