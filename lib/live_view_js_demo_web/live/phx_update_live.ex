defmodule LiveViewJsDemoWeb.PhxUpdateLive do
  use LiveViewJsDemoWeb, :live_view

  @items [
    %{
      title: "What is LiveView?",
      description:
        "Phoenix LiveView is a real-time web framework built on top of the Phoenix framework for Elixir. It enables developers to create interactive, dynamic web applications without writing JavaScript. LiveView works by maintaining a persistent connection between the client and server, allowing server-side code to push updates to the client whenever the application state changes. This approach minimizes the need for manual DOM manipulation and simplifies the development of complex, reactive user interfaces."
    },
    %{
      title: "What is JavaScript?",
      description:
        "JavaScript is a versatile programming language commonly used for creating dynamic and interactive web content. Initially developed for adding interactivity to web pages, JavaScript has evolved into a multi-paradigm language capable of handling tasks ranging from simple client-side scripting to complex server-side development. It is supported by all modern web browsers and allows developers to manipulate the Document Object Model (DOM), handle events, communicate asynchronously with servers using AJAX, create animations, and build full-fledged web applications. JavaScript's popularity stems from its flexibility, wide adoption, and extensive ecosystem of libraries and frameworks."
    }
  ]

  def mount(_params, _session, socket) do
    {:ok, assign(socket, page_title: "phx-update", counter: 1, items: @items)}
  end

  def handle_event("update_counter", _params, socket) do
    {:noreply, assign(socket, :counter, socket.assigns.counter + 1)}
  end

  def render(assigns) do
    ~H"""
    <section>
      <div phx-update="ignore" id="accordion-collapse" data-accordion="collapse" class="w-full">
        <%= for {item, index} <- Enum.with_index(@items) do %>
          <h2 id={"accordion-collapse-heading-#{index}"}>
            <button
              type="button"
              class="flex items-center justify-between gap-3 w-full p-5 font-semibold border border-b-0 last:border-b text-white border-gray-600 bg-gray-700 hover:bg-blue-300 hover:text-black"
              data-accordion-target={"#accordion-collapse-body-#{index}"}
              aria-controls={"accordion-collapse-body-#{index}"}
            >
              <%= item.title %>
            </button>
          </h2>
          <div
            id={"accordion-collapse-body-#{index}"}
            class="hidden w-fit"
            aria-labelledby={"accordion-collapse-heading-#{index}"}
          >
            <p class="p-5 bg-gray-600 shadow-inner">
              <%= item.description %>
            </p>
          </div>
        <% end %>
      </div>

      <div class="flex flex-col items-center gap-5 mt-5">
        <button class="btn" phx-click="update_counter">Update very useful counter</button>
        <h3>Counter: <%= @counter %></h3>
      </div>
    </section>
    """
  end
end
