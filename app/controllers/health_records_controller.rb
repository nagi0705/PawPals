class HealthRecordsController < ApplicationController
  before_action :set_pet
  before_action :set_health_record, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  before_action :correct_user_or_admin, only: [:show, :edit, :update, :destroy]

  def index
    @health_records = @pet.health_records
  end

  def show
  end

  def new
    @health_record = @pet.health_records.new
  end

  def create
    @health_record = @pet.health_records.new(health_record_params)
    if @health_record.save
      redirect_to pet_health_records_path(@pet), notice: '健康記録が作成されました。'
    else
      flash.now[:alert] = '健康記録の作成に失敗しました。'
      render :new
    end
  end

  def edit
  end

  def update
    if @health_record.update(health_record_params)
      redirect_to pet_health_record_path(@pet, @health_record), notice: '健康記録が更新されました。'
    else
      flash.now[:alert] = '健康記録の更新に失敗しました。'
      render :edit
    end
  end

  def destroy
    @health_record.destroy
    redirect_to pet_health_records_path(@pet), notice: '健康記録が削除されました。'
  end

  private

  def set_pet
    @pet = Pet.find(params[:pet_id])
  end

  def set_health_record
    @health_record = @pet.health_records.find(params[:id])
  end

  def health_record_params
    params.require(:health_record).permit(:walked, :morning_meal, :evening_meal, :note)
  end

  def correct_user_or_admin
    unless current_user == @pet.user || current_user.admin?
      redirect_to pets_path, alert: 'アクセス権限がありません。'
    end
  end
end
