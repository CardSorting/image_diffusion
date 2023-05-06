defmodule ImageDiffusion.ImageStore do
  use Waffle.Definition

  @versions [:original]

  @impl Waffle.Definition
  def public_url(file, %{}) do
    Waffle.Storage.S3.url(file)
  end
end
