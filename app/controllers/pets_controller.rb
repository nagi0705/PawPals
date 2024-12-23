class PetsController < ApplicationController
  before_action :set_pet, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  before_action :authorize_user!, only: [:edit, :update, :destroy]

  def index
    @pets = Pet.all
  end

  def show
  end

  def new
    @pet = Pet.new
  end

  def create
    @pet = current_user.pets.build(pet_params)
    if @pet.save
      redirect_to @pet, notice: 'ペットが登録されました。'
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @pet.update(pet_params)
      redirect_to @pet, notice: 'ペット情報が更新されました。'
    else
      render :edit
    end
  end

  def destroy
    @pet.destroy
    redirect_to pets_url, notice: 'ペットが削除されました。'
  end

  def search
    @pets = Pet.where('name LIKE ?', "%#{params[:query]}%")
    render :index
  end

  private

  def set_pet
    @pet = Pet.find(params[:id])
  end

  def pet_params
    params.require(:pet).permit(:name, :species, :kind, :image).tap do |pet_params|
      if params[:pet][:birth_year].present? && params[:pet][:birth_month].present? && params[:pet][:birth_day].present?
        pet_params[:birth_date] = Date.new(params[:pet][:birth_year].to_i, params[:pet][:birth_month].to_i, params[:pet][:birth_day].to_i)
      end
    end
  end

  def authorize_user!
    unless current_user == @pet.user || current_user.admin?
      redirect_to pets_path, alert: 'アクセス権限がありません。'
    end
  end
end
