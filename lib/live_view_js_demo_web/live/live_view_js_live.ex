defmodule LiveViewJsDemoWeb.LiveViewJsLive do
  use LiveViewJsDemoWeb, :live_view

  @terms_and_conditions "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Proin iaculis, ipsum sed convallis elementum, odio lacus tristique ligula, sed dictum est eros vitae nulla. Donec feugiat aliquet convallis. Fusce interdum lorem est, eu volutpat nulla pharetra et. Pellentesque feugiat ligula quis mauris volutpat, quis mollis mi bibendum. Donec in convallis nisi. Integer commodo fringilla maximus. Fusce accumsan dui ac felis fermentum consequat ac in eros. Donec eu mi ac velit luctus varius nec ac mi. Etiam ut elit elit. Praesent nisi tortor, euismod et tristique at, lacinia vitae turpis. Nullam vitae sem orci."

  def mount(_params, _session, socket) do
    {:ok, assign(socket, page_title: "LiveView.JS", terms_and_conditions: @terms_and_conditions)}
  end

  def render(assigns) do
    ~H"""
    <section>
      <div class="flex gap-2 items-center justify-center mb-5">
        <span class="hero-document-text w-10 h-10" />
        <h3>Terms of Service</h3>
      </div>
      <div class="border border-gray-600 bg-gray-700 p-10 rounded-md">
        <p><%= @terms_and_conditions %></p>
      </div>
      <div class="flex items-center mt-4 mb-4">
        <input
          id="default-checkbox"
          phx-change={JS.toggle_attribute({"disabled", "true"}, to: "#continue-button")}
          type="checkbox"
          class="w-4 h-4 text-blue-600 bg-gray-100 border-gray-300 rounded focus:ring-blue-500"
        />
        <label for="default-checkbox" class="ml-2 text-sm font-medium">
          I accept the terms and conditions
        </label>
      </div>
      <div class="flex justify-center">
        <button id="continue-button" disabled class="btn">
          Continue
        </button>
      </div>
    </section>
    """
  end
end
