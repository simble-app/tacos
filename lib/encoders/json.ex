defmodule Tacos.Encoders.Json do
  @behaviour Tacos.Encoder

  alias Poison.Encoder

  def encode(data) when is_list(data) or is_map(data) do
    "#{Poison.Encoder.encode(data, nil)}"
  end
end
