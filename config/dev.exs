use Mix.Config
config :chat, remote_supervisor: fn(recipient) -> {Smoggach.TaskSupervisor, recipient} end
