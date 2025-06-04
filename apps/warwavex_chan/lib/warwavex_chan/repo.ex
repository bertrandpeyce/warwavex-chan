defmodule WarwavexChan.Repo do
  use Ecto.Repo,
    otp_app: :warwavex_chan,
    adapter: Ecto.Adapters.Postgres
end
