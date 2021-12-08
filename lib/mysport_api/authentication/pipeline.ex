defmodule MysportApi.Authentication.Pipeline do
  @claims %{typ: "access"}

  use Guardian.Plug.Pipeline,
  otp_app: :mysport_api,
  module: MysportApi.Authentication.Guardian,
  error_handler: MysportApi.Authentication.ErrorHandler


plug(Guardian.Plug.VerifyHeader, claims: @claims, realm: "Bearer")
plug(Guardian.Plug.EnsureAuthenticated)
plug(Guardian.Plug.LoadResource, ensure: true)



end
