class UsersController < ApplicationController
  # GET /users/1 or /users/1.json
  def show
    @user = User.find_by(screen_name: params[:screen_name])
    if @user
      render json: @user
    else
      render json: { error: "Not Found" }, status: :not_found
    end
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users or /users.json
  def create
    @user = User.new(user_params)

    if @user.save
      render json: @user, status: :created
    else
      render status: 400
    end
  end

  # PATCH/PUT /users/1 or /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: "User was successfully updated.", status: :see_other }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1 or /users/1.json
  def destroy
    @user.destroy!

    respond_to do |format|
      format.html { redirect_to users_path, notice: "User was successfully destroyed.", status: :see_other }
      format.json { head :no_content }
    end
  end

  private

    # Only allow a list of trusted parameters through.
    def user_params
      params.expect(user: [ :email, :screen_name, :password ])
    end
end
