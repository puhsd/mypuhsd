class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  # GET /users
  # GET /users.json
  def index
    # @users = User.all
    authorize User, :index?
    @users = User.order('created_at DESC').limit(100)
  end

  # GET /users/1
  # GET /users/1.json
  def show
    # authorize @user
    authorize @user, :show?
    if @user == nil
      redirect_to '/'
    end
  end

  # GET /users/new
  def new
    authorize User, :new?
    @user = User.new
  end

  # GET /users/1/edit
  def edit
    authorize User, :edit?
  end

  # POST /users
  # POST /users.json
  def create
    authorize User, :create?
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, notice: 'User was successfully created.' }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    authorize User, :update?
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    authorize User, :destroy?
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end


  def import
    authorize User, :import?
      if User.start_import
        redirect_to users_url, notice: 'Successfully synchronized users with LDAP.'
      else
        redirect_to users_url, alert: 'Could not synchronize users with LDA.'
      end

  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user

      # @user = User.find(params[:id])

      if params[:id]
        @user = User.friendly.find(params[:id])
      else
        @user = current_user
      end


    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:email, :firstname, :lastname, :access_level)
    end
end
