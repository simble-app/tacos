defmodule Mix.Tasks.Tacos.Gen.Model do
  use Mix.Task

  import Mix.Generator
  import Mix.Utils, only: [camelize: 1, underscore: 1]

  @shortdoc "Generate a new taco from an ecto model"
  def run(args) do
    Mix.Task.run "app.start", []

    for {model, taco} <- Tacos.Generators.EctoModel.run(args),
      tacos_path <- Tacos.all_tacos_paths do
        taco_path = Path.join(tacos_path, "#{underscore(model)}.json")
        cond do
          File.exists?(taco_path) -> Mix.shell.info([:green, "* skipping ", :reset, "Taco exists #{taco_path}"])
          true -> create_file taco_path, taco
        end
    end
  end
end
