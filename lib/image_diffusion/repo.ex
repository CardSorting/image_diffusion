defmodule ImageDiffusion.Repo do
  use Ecto.Repo,
    otp_app: :image_diffusion,
    adapter: Ecto.Adapters.Postgres
end
