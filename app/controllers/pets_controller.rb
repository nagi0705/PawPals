class PetsController < ApplicationController
  def index
    @pets = current_user.pets
  end

  def new
    @pet = Pet.new
  end

  def create
    @pet = current_user.pets.build(pet_params)
    if @pet.save
      redirect_to pets_path, notice: 'ペットが登録されました。'
    else
      render :new
    end
  end

  def show
    @pet = current_user.pets.find(params[:id])
  end

  def edit
    @pet = current_user.pets.find(params[:id])
  end

  def update
    @pet = current_user.pets.find(params[:id])
    if @pet.update(pet_params)
      redirect_to pets_path, notice: 'ペット情報が更新されました。'
    else
      render :edit
    end
  end

  def destroy
    @pet = current_user.pets.find(params[:id])
    @pet.destroy
    redirect_to pets_path, notice: 'ペットが削除されました。'
  end

  private

  def pet_params
    params.require(:pet).permit(:name, :species, :age, :kind)
  end
end
