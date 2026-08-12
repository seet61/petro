# Petro.Umbrella

To start your Phoenix server: 

* Run `mix setup` to install and setup dependencies
* Start Phoenix endpoint with `mix phx.server` or inside IEx with `iex -S mix phx.server` 

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

Ready to run in production? Please [check our deployment guides](https://phoenix.hexdocs.pm/deployment.html).
## Umbrella project

This is an Elixir umbrella project. It is composed of multiple apps:

* [Petro](apps/petro) - The core logic for web
* [PetroWeb](apps/petro_web) - The Phoenix web interface
* [PetroAmqp](apps/petro_amqp) - The backend logic for RabbitMQ
* [PetroDB](apps/petro_db) - The abstract layer for DataBase entities
