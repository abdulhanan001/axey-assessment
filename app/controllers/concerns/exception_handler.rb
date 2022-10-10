# frozen_string_literal: true

module ExceptionHandler
  extend ActiveSupport::Concern

  included do
    rescue_from ActiveRecord::RecordNotFound do
      render json: { message: "User you are looking for doesn't exist" }, status: :unprocessable_entity
    end
  end
end
