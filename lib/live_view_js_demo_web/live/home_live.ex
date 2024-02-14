defmodule LiveViewJsDemoWeb.HomeLive do
  use LiveViewJsDemoWeb, :live_view

  def mount(_params, _session, socket) do
    {:ok, assign(socket, :page_title, "Examples")}
  end

  def render(assigns) do
    ~H"""
    <section>
      <ul>
        <li><.link class="font-semibold" href={~p"/phx-update"}>phx-update</.link></li>
        <li><.link class="font-semibold" href={~p"/phx-hook"}>phx-hook</.link></li>
        <li><.link class="font-semibold" href={~p"/liveview-js"}>LiveView.JS</.link></li>
        <li>
          <.link class="font-semibold" href={~p"/on-before-el-updated"}>
            onBeforeElUpdated Callback
          </.link>
        </li>
      </ul>
    </section>
    """
  end
end
