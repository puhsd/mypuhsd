class PasswordsController < ApplicationController
  before_action :set_password, only: [:show, :edit, :update, :destroy]

  # GET /passwords
  # GET /passwords.json
  def index
    authorize Password, :index?
    @passwords = Password.all.order('created_at DESC').limit(100)
  end

  # GET /passwords/1
  # GET /passwords/1.json
  def show
    authorize Password, :show?
  end

  # GET /passwords/new
  def new
    authorize Password, :new?
    @password = Password.new
  end

  # GET /passwords/1/edit
  def edit
    authorize Password, :edit?
  end

  # POST /passwords
  # POST /passwords.json
  def create
    authorize Password, :create?
    @password = Password.new(password_params)

    respond_to do |format|
      if @password.save
        format.html { redirect_to @password, notice: 'Password was successfully created.' }
        format.json { render :show, status: :created, location: @password }
      else
        format.html { render :new }
        format.json { render json: @password.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /passwords/1
  # PATCH/PUT /passwords/1.json
  def update
    authorize Password, :update?
    respond_to do |format|
      if @password.update(password_params)
        format.html { redirect_to @password, notice: 'Password was successfully updated.' }
        format.json { render :show, status: :ok, location: @password }
      else
        format.html { render :edit }
        format.json { render json: @password.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /passwords/1
  # DELETE /passwords/1.json
  def destroy
    authorize Password, :destroy?
    @password.destroy
    respond_to do |format|
      format.html { redirect_to passwords_url, notice: 'Password was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_password
      @password = Password.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def password_params
      params.require(:password).permit(:user_id, :vendor, :username, :password)
    end
end
