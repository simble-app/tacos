defmodule Tacos.Parser do
  use Behaviour

  @doc "Parse the given string"
  defcallback parse(data :: String.t) :: any
end
