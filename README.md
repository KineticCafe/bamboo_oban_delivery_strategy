# Bamboo.ObanDeliveryStrategy

A delivery strategy for [Bamboo][] that uses [Oban][]. We haven't used this in
a while, so it might not work anymore.

## Installation

1. Add `bamboo`, `oban`, and `bamboo_oban_delivery_strategy` to your `mix.exs`:

   ```elixir
   def deps do
     [
       {:bamboo, "~> 1.0"},
       {:oban, "~> 2.0"},
       {:bamboo_oban_delivery_strategy, "~> 1.0"}
       # OR: {:bamboo_oban_delivery_strategy, github: "KineticCafe/bamboo_oban_delivery_strategy"}
     ]
   end
   ```

2. Follow the Bamboo [Getting Started Guide][getting_started].

3. Follow the Oban [Installation][oban_installation] guide

4. Add `Bamboo.ObanDeliveryStrategy` to your mailer configuration. Optionally
   configure the queue and maximum attempts.

   ```elixir
   # In your config/config.exs file
   deliver_later_strategy =
     if Mix.env() == :test do
       Bamboo.ImmediateDeliveryStrategy
     else
       Bamboo.ObanDeliveryStrategy
     end

   config :my_app, MyApp.Mailer, deliver_later_strategy: deliver_later_strategy

   # Optional, but recommended. If not provided, defaults to "default" and 10
   # attempts.
   configure :bamboo, ObanDeliveryStrategy, queue: "mailers", max_attempts: 15
   ```

## Community and Contributing

We welcome your contributions, as described in [Contributing.md][]. Like all
Kinetic Cafe [open source projects][], is under the Kinetic Cafe Open Source
[Code of Conduct][kccoc].

[elastic email]: https://elasticemail.com/
[bamboo]: https://github.com/thoughtbot/bamboo
[oban]: https://github.com/sorentwo/oban
[hex.pm]: https://hex.pm
[getting_started]: https://github.com/thoughtbot/bamboo#getting-started
[contributing.md]: Contributing.md
[open source projects]: https://github.com/KineticCafe
[kccoc]: https://github.com/KineticCafe/code-of-conduct
[oban_installation]: https://hexdocs.pm/oban/installation.html
