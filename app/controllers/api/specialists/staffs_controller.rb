class Api::Specialists::StaffsController < ApplicationController
  before_action :set_staff, only: [:show, :update, :destroy]
  before_action :authenticate_specialist!

  def index
    @order_staffs = current_specialist.office.staffs.order(updated_at: :desc)
    @data_length = @order_staffs.count
    if params[:page].blank?
      @staffs = @order_staffs
      render json: { staffs: @staffs, data_length: @data_length }, methods: [:image_url]
    else
      @staffs = @order_staffs.limit(10).offset(params[:page].to_i * 10)
      render json: { staffs: @staffs, data_length: @data_length }, methods: [:image_url]
    end
  end

  def show
    render json: @staff, methods: [:image_url]
  end

  def create
    @staff = current_specialist.office.staffs.build(staff_params)
    if @staff.valid?
      @staff.save!
    else
      render json: { status: @staff.errors.full_messages }
    end
  end

  def update
    if @staff.valid?
      @staff.update(staff_params)
      render json: { status: 'success' }
    else
    render json: { status: @staff.errors.full_messages }
    end
  end

  def destroy
    if @staff.valid?
      @staff.destroy
      render json: { status: 'success' }
    else
      render json: { status: @staff.errors.full_messages }
    end
  end

  private

    def staff_params
      params.permit(:office_id, :name, :kana, :introduction, :image)
    end

    def set_staff
      @staff = current_specialist.office.staffs.find(params[:id])
      @office = current_specialist.office.id
    end
  end
