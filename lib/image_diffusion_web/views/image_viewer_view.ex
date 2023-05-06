defmodule ImageDiffusionWeb.ImageViewerView do
  use ImageDiffusionWeb, :view
end
def handle_event("generate", %{"prompt" => prompt}, socket) do
  case ImageDiffusion.get_image(prompt) do
    {:ok, data} ->
      image_url = data.storage |> elem(1)
      {:noreply, assign(socket, :generated_image, image_url)}
    {:error, _} ->
      {:noreply, socket}
  end
end
