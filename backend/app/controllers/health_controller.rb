class HealthController < ApplicationController
  skip_before_action :authenticate_user!

  def index
    render json: { ok: true, message: "Backend funcionando" }
  end
end
