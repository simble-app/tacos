defmodule Tacos.Encoder do
  use Behaviour

  @doc "Parse the given string"
  defcallback encode(data :: [any] | %{}) :: String.t
end
