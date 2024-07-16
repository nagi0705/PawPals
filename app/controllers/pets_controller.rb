class PetsController < ApplicationController
  before_action :set_pet, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!

  # GET /pets
  def index
    @pets = Pet.all.includes(:user) # includesを使って関連するユーザーをプリロード
  end

  # GET /pets/1
  def show
  end

  # GET /pets/new
  def new
    @pet = current_user.pets.build
  end

  # GET /pets/1/edit
  def edit
    redirect_to pets_path, alert: '権限がありません' unless @pet.user == current_user
  end

  # POST /pets
  def create
    @pet = current_user.pets.build(pet_params)

    if @pet.save
      redirect_to @pet, notice: 'ペットが登録されました'
    else
      render :new
    end
  end

  # PATCH/PUT /pets/1
  def update
    if @pet.user == current_user && @pet.update(pet_params)
      redirect_to @pet, notice: 'ペットが更新されました'
    else
      render :edit
    end
  end

  # DELETE /pets/1
  def destroy
    if @pet.user == current_user
      @pet.destroy
      redirect_to pets_url, notice: 'ペットが削除されました'
    else
      redirect_to pets_url, alert: '権限がありません'
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_pet
      @pet = Pet.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def pet_params
      params.require(:pet).permit(:name, :species, :age, :kind, :image)
    end
end
