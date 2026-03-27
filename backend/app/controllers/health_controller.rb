class HealthController < ApplicationController
  def index
    render json: { ok: true, message: "Backend funcionando" }
  end
end