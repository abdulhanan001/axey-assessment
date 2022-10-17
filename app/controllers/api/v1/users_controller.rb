# frozen_string_literal: true

module Api
  module V1
    class UsersController < ApplicationController
      before_action :set_user, only: %i[show update destroy]

      def index
        render json: { users: User.all }
      end

      def create
        user = User.new(user_params)
        if user.save
          render json: user, status: :created
        else
          render json: { message: user.errors.full_messages }, status: :unprocessable_entity
        end
      end

      def show
        if @user
          render json: @user, status: :found
        else
          render json: { message: 'User not found.' }, status: :not_found
        end
      end

      def update
        if @user.update(user_params)
          render json: @user, status: :ok
        else
          render json: { message: @user.errors.full_messages }, status: :unprocessable_entity
        end
      end

      def destroy
        if @user.destroy
          render json: { message: 'User successfully destroyed.' }, status: :ok
        else
          render json: { message: @user.errors.full_messages }, status: :unprocessable_entity
        end
      end

      private

      def user_params
        params.permit(:first_name, :last_name, :address, :email)
      end

      def set_user
        @user = User.find(params[:id])
      end
    end
  end
end
