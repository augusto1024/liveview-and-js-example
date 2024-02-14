defmodule LiveViewJsDemoWeb.Router do
  use LiveViewJsDemoWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, html: {LiveViewJsDemoWeb.Layouts, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", LiveViewJsDemoWeb do
    pipe_through :browser

    live "/", HomeLive
    live "/phx-update", PhxUpdateLive
    live "/liveview-js", LiveViewJsLive
    live "/phx-hook", PhxHookLive
  end

  # Other scopes may use custom stacks.
  # scope "/api", LiveViewJsDemoWeb do
  #   pipe_through :api
  # end

  # Enable Swoosh mailbox preview in development
  if Application.compile_env(:live_view_js_demo, :dev_routes) do
    scope "/dev" do
      pipe_through :browser

      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end
end
