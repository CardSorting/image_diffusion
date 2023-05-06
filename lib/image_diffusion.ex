defmodule ImageDiffusion do
  require Logger
  alias Finch.Response

  # Replace with your Runpod API key
  @api_key "your_api_key_here"

  def get_image(prompt) do
    url = "https://api.runpod.ai/v2/stable-diffusion-v1/runsync"
    headers = [
      {"accept", "application/json"},
      {"content-type", "application/json"},
      {"authorization", "bearer #{@api_key}"}
    ]
    body = %{
      "input" => %{
        "prompt" => prompt,
        "width" => 512,
        "height" => 512,
        "guidance_scale" => 7.5,
        "num_inference_steps" => 50,
        "num_outputs" => 1,
        "prompt_strength" => 1,
        "scheduler" => "K-LMS"
      }
    }

    case Finch.post(:finch, url, headers, Jason.encode!(body)) do
      {:ok, %Response{status: 200, body: body}} ->
        {:ok, Jason.decode!(body)}
      {:ok, %Response{status: status, body: body}} ->
        Logger.warn(fn -> "Response: #{status} - #{body}" end)
        {:error, :api_error}
      {:error, reason} ->
        Logger.warn(fn -> "Request error: #{inspect(reason)}" end)
        {:error, :request_error}
    end
  end
end
