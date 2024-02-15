defmodule LiveViewJsDemoWeb.OnBeforeElUpdatedLive do
  use LiveViewJsDemoWeb, :live_view

  @users [
    "johndoe",
    "janedoe"
  ]

  def mount(_params, _session, socket) do
    {:ok,
     assign(
       socket,
       page_title: "onBeforeElUpdated Callback",
       users: @users,
       user_form: to_form(%{"name" => ""}),
       message: nil,
       error: true
     )}
  end

  def handle_event("validate_user", %{"user" => %{"name" => name}}, socket) do
    name = String.downcase(name)

    cond do
      String.length(name) == 0 ->
        {:noreply, assign(socket, error: true, message: nil)}

      Enum.member?(socket.assigns.users, name) ->
        {:noreply, assign(socket, error: true, message: "\"#{name}\" is already registeded")}

      true ->
        {:noreply, assign(socket, error: false, message: "\"#{name}\" is available")}
    end
  end

  def handle_event("save_user", %{"user" => %{"name" => name}}, socket) do
    name = String.downcase(name)

    {:noreply, assign(socket, users: [name | socket.assigns.users])}
  end

  def handle_event("delete_user", %{"username" => username}, socket) do
    {:noreply,
     assign(socket,
       users: Enum.filter(socket.assigns.users, &(&1 != username))
     )}
  end

  def render(assigns) do
    ~H"""
    <section>
      <div class="flex justify-end mb-5">
        <button
          data-modal-target="new-user-modal"
          data-modal-toggle="new-user-modal"
          class="btn"
          type="button"
        >
          Add new user
        </button>
      </div>

      <table class="w-full text-sm text-left rtl:text-right text-gray-200">
        <thead class="text-xs uppercase bg-gray-700 text-gray-200">
          <tr>
            <th scope="col" class="px-6 py-3">
              Username
            </th>
            <th scope="col" class="px-6 py-3 text-right" />
          </tr>
        </thead>
        <tbody>
          <tr :if={length(@users) == 0}>
            <td class="text-center p-2 text-xl" colspan="2">No users exists</td>
          </tr>
          <tr :for={user <- @users} class="border-b last:border-none bg-gray-800 border-gray-700">
            <td scope="row" class="px-6 py-4">
              <%= user %>
            </td>
            <td class="px-6 py-4 text-right">
              <button
                phx-value-username={user}
                phx-click="delete_user"
                class="p-2 rounded-full hover:bg-white hover:bg-opacity-10  hover:shadow-sm transition-colors delay-75"
              >
                <span class="hero-trash" />
              </button>
            </td>
          </tr>
        </tbody>
      </table>
      <div
        id="new-user-modal"
        tabindex="-1"
        aria-hidden="true"
        class="hidden overflow-y-auto overflow-x-hidden fixed top-0 right-0 left-0 z-50 justify-center items-center w-full md:inset-0 h-[calc(100%-1rem)] max-h-full"
        phx-keep-class
        phx-keep-aria-modal
        phx-keep-role
        phx-keep-aria-hidden
      >
        <div class="relative p-4 w-full max-w-2xl max-h-full">
          <div class="relative rounded-md shadow bg-gray-700">
            <div class="flex items-center justify-between p-4 md:p-5">
              <h3>New user</h3>
            </div>
            <div class="p-4 md:p-5 space-y-4">
              <.form phx-change="validate_user" phx-submit="save_user" for={@user_form}>
                <div class="mb-5">
                  <label for="user_name" class="block mb-1 font-bold text-white">
                    Username
                  </label>
                  <input
                    phx-debounce="500"
                    id="user_name"
                    name="user[name]"
                    type="text"
                    class="border text-sm rounded-md block w-full p-2.5 bg-gray-700 border-gray-600 text-white focus:ring-blue-500 focus:border-blue-500"
                    required
                  />
                  <p :if={@error && @message} class="text-red-500 font-semibold"><%= @message %></p>
                  <p :if={!@error && @message} class="text-green-500 font-semibold">
                    <%= @message %>
                  </p>
                </div>
                <div class="flex justify-end">
                  <button disabled={@error} data-modal-hide="new-user-modal" class="btn" type="submit">
                    Save
                  </button>
                </div>
              </.form>
            </div>
          </div>
        </div>
      </div>
    </section>
    """
  end
end
