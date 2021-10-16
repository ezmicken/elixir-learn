defmodule Smoggach.Chat do
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      {Task.Supervisor, name: Smoggach.TaskSupervisor}
    ]

    opts = [strategy: :one_for_one, name: Smoggach.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
