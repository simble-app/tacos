defmodule Mix.Tasks.Tacos.Setup do
  use Mix.Task
  import Mix.Generator

  @shortdoc "Setup Tacos in an existing app"
  def run(_) do
    for path <- Tacos.default_test_paths do
      cond do
        File.dir?(path) ->
          Mix.shell.info([:green, "* skipping ", :reset, "Directory exists #{path}"])

        true ->
          create_directory path
      end
    end
  end
end
