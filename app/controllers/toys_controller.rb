class ToysController < ApplicationController
  wrap_parameters format: []
  rescue_from ActiveRecord::RecordInvalid, with: :invalid_record_response
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found_response

  def index
    toys = Toy.all
    render json: toys
  end

  def create
    toy = Toy.create!(toy_params)
    render json: toy, status: :created
  end

  def update
    toy = find_toy
    toy.update!(toy_params)
    render json: toy
  end

  def destroy
    toy = find_toy
    toy.destroy
    head :no_content
  end

  private
  
  def toy_params
    params.permit(:name, :image, :likes)
  end

  def find_toy
    Toy.find(params[:id])
  end

  def invalid_record_response(invalid)
    render json: { errors: invalid.record.errors.full_messages }, status: :unprocessable_entity
  end

  def record_not_found_response
    render json: { errors: "Record Not Found" }
  end

end
