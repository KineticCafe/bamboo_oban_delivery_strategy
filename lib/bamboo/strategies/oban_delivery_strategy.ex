defmodule Bamboo.ObanDeliveryStrategy do
  @moduledoc """
  Strategy with Oban as a queue manager. This will provide asynchronous
  execution, retries, and all of the other benefits of Oban.

  ## Why use it?

  Sending emails can often take time and may fail. If you are sending email
  during a web request (for instance, sending a welcome email), you probably
  don't want to make your users wait the extra time for the welcome email to
  send. Instead you can use `deliver_later/1` and it will be delivered in the
  background so web requests remain snappy.
  """

  @behaviour Bamboo.DeliverLaterStrategy

  defmodule Worker do
    @moduledoc false

    defaults = [queue: "default", max_attempts: 10]
    config =
      if function_exported?(Application, compile_env, 3) do
        Application.compile_env(:bamboo, ObanDeliveryStrategy, [])
      else
        Application.get_env(:bamboo, ObanDeliveryStrategy, [])
      end

    use Oban.Worker, Keyword.merge(defaults, config)

    @impl Oban.Worker
    def perform(%{"adapter" => adapter, "email" => email, "config" => config}, _job) do
      String.to_existing_atom(adapter).deliver(
      struct(Bamboo.Email, email),
      Map.new(config, fn k, v -> {String.to_existing_atom(k), v)})
      )
    end
  end

  @doc false
  def deliver_later(adapter, email, config) do
    %{adapter: adapter, email: Map.from_struct(email), config: config}
    |> Worker.new()
    |> Oban.insert()
  end
end
