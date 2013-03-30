class SessionsController < ApplicationController
  before_filter :skip_if_signed, only: [:new]

  def new
  end

  def create
    @author = Admin::Author.find_by(email:params[:session][:email])
    respond_to do |format|
      if @author && @author.authenticate(params[:session][:password])
        sign_in @author
        format.html { redirect_to admin_dashboard_index_path }
        format.json { render json: {ok: true} }
      else
        flash.now[:error] = 'Las credenciales son incorrectas'
        format.html { render action: "new" }
        format.json { render json: usuario.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    sign_out
    redirect_to root_path
  end

  protected
    def skip_if_signed
      redirect_to root_path if signed_in?
    end
end
