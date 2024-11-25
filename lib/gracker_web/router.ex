defmodule GrackerWeb.Router do
  use GrackerWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, html: {GrackerWeb.Layouts, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", GrackerWeb do
    pipe_through :browser

    get "/", PageController, :hello
  end

  scope "/products", GrackerWeb do
    pipe_through :browser
    resources "/", ProductController
    get "/:id/price", ProductController, :price
    post "/:id/price", ProductController, :add_price
    post "/qr", ProductController, :create_from_qr
  end

  scope "/stores", GrackerWeb do
    pipe_through :browser
    resources "/", StoreController
  end
  


  # Other scopes may use custom stacks.
  # scope "/api", GrackerWeb do
  #   pipe_through :api
  # end

  # Enable LiveDashboard and Swoosh mailbox preview in development
  if Application.compile_env(:gracker, :dev_routes) do
    # If you want to use the LiveDashboard in production, you should put
    # it behind authentication and allow only admins to access it.
    # If your application does not have an admins-only section yet,
    # you can use Plug.BasicAuth to set up some basic authentication
    # as long as you are also using SSL (which you should anyway).
    import Phoenix.LiveDashboard.Router

    scope "/dev" do
      pipe_through :browser

      live_dashboard "/dashboard", metrics: GrackerWeb.Telemetry
      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end
end
