class VendorsController < ApplicationController
  before_action :set_vendor, only: [:show, :edit, :update, :destroy, :remove_logo]

  # GET /vendors
  # GET /vendors.json
  def index
    authorize Vendor, :index?
    @vendors = Vendor.all
  end

  # GET /vendors/1
  # GET /vendors/1.json
  def show
    authorize Vendor, :show?
    @upload = Upload.new
    @upload.vendor_id = @vendor.id
  end

  # GET /vendors/new
  def new
    authorize Vendor, :new?
    @vendor = Vendor.new
  end

  # GET /vendors/1/edit
  def edit
    authorize Vendor, :edit?
  end

  # POST /vendors
  # POST /vendors.json
  def create
    authorize Vendor, :create?
    @vendor = Vendor.new(vendor_params)

    respond_to do |format|
      if @vendor.save
        format.html { redirect_to @vendor, notice: 'Vendor was successfully created.' }
        format.json { render :show, status: :created, location: @vendor }
      else
        format.html { render :new }
        format.json { render json: @vendor.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /vendors/1
  # PATCH/PUT /vendors/1.json
  def update
    authorize Vendor, :update?
    respond_to do |format|
      if @vendor.update(vendor_params)
        format.html { redirect_to @vendor, notice: 'Vendor was successfully updated.' }
        format.json { render :show, status: :ok, location: @vendor }
      else
        format.html { render :edit }
        format.json { render json: @vendor.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /vendors/1
  # DELETE /vendors/1.json
  def destroy
    authorize Vendor, :destroy?
    @vendor.destroy
    respond_to do |format|
      format.html { redirect_to vendors_url, notice: 'Vendor was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def remove_logo
    authorize Vendor, :update?
    @vendor.remove_logo
    respond_to do |format|
      format.html { redirect_to @vendor, notice: 'Vendor Logo was successfully removed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_vendor
      @vendor = Vendor.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def vendor_params
      params.require(:vendor).permit(:title, :link, :logo, :logonform, :showto)
    end
end
