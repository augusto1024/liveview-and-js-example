defmodule LiveViewJsDemoWeb.PhxHookLive do
  use LiveViewJsDemoWeb, :live_view

  def mount(_params, _session, socket) do
    {:ok, assign(socket, page_title: "phx-hook")}
  end

  def render(assigns) do
    ~H"""
    <section>
      <div>
        <div
          id="dark-mode-toggle"
          data-dark-mode-input="dark-mode-input"
          phx-hook="DarkMode"
          class="flex items-center"
        >
          <span class="hero-sun w-5 h-5 mr-3" />
          <label class="inline-flex items-center cursor-pointer">
            <input id="dark-mode-input" type="checkbox" value="" class="sr-only peer" />
            <div class="relative w-11 h-6 bg-gray-200 peer-focus:outline-none peer-focus:ring-4 peer-focus:ring-blue-300 rounded-full peer peer-checked:after:translate-x-full rtl:peer-checked:after:-translate-x-full peer-checked:after:border-white after:content-[''] after:absolute after:top-[2px] after:start-[2px] after:bg-white after:border-gray-300 after:border after:rounded-full after:h-5 after:w-5 after:transition-all peer-checked:bg-blue-600" />
          </label>
          <span class="hero-moon w-5 h-5 ml-3" />
        </div>
        <div class="flex justify-center mt-5 p-10 rounded-xl dark:text-gray-800 dark:bg-white border border-gray-600 dark:border-gray-200">
          <h3>Hello there!</h3>
        </div>
      </div>
    </section>
    """
  end
end
