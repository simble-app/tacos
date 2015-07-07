defmodule Tacos.Parsers.Json do
  @behaviour Tacos.Parser

  alias Poison.Parser

  def parse(data) do
    case Parser.parse(data) do
      {:ok, json} ->
        json
      _ ->
        raise "Invalid taco! The taco #{data} is not valid JSON."
    end
  end
end
