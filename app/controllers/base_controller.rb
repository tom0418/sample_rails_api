class BaseController < ApplicationController
  # 404 Not Found
  rescue_from ActiveRecord::RecordNotFound do
    render json: { error: "Record not found" }, status: :not_found
  end

  # 422 Validation failed
  rescue_from ActiveRecord::RecordInvalid do |e|
    render json: { error: e.message }, status: :unprocessable_entity
  end
end
