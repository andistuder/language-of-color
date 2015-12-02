class MembersController < ApplicationController
  before_action :set_member, only: [:show, :edit, :update, :destroy]

  def index
    if ENV['MEMBERS_DISABLED'] && !current_member.try(:is_admin?)
      redirect_to '/', notice: 'Membership page temporarily unavailable.'
    else
      @members = Member.all
      respond_to do |format|
        format.html
        format.csv do
          if current_member.try(:is_admin?)
            send_data @members.to_csv
          else
            render plain: '403 Forbidden', status: 403 unless current_member.try(:is_admin?)
          end
        end
      end
    end
  end

  # GET /members/1
  # GET /members/1.json
  def show
  end

  # GET /members/new
  def new
    if ENV['MEMBERS_DISABLED']
      redirect_to '/', notice: 'Membership page temporarily unavailable.'
    else
      @member = Member.new
    end
  end

  # GET /members/1/edit
  def edit
  end

  # POST /members
  # POST /members.json
  def create
    if ENV['MEMBERS_DISABLED']
      render plain: '503 Service unavailable. Try again later.', status: 503
    else
      @member = Member.new(member_params)

      respond_to do |format|
        if @member.save
          format.html { redirect_to @member, notice: 'Member was successfully created.' }
          format.json { render :show, status: :created, location: @member }
        else
          format.html { render :new }
          format.json { render json: @member.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  # PATCH/PUT /members/1
  # PATCH/PUT /members/1.json
  def update
    respond_to do |format|
      if @member.update(member_params)
        format.html { redirect_to @member, notice: 'Member was successfully updated.' }
        format.json { render :show, status: :ok, location: @member }
      else
        format.html { render :edit }
        format.json { render json: @member.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /members/1
  # DELETE /members/1.json
  def destroy
    @member.destroy
    respond_to do |format|
      format.html { redirect_to members_url, notice: 'Member was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_member
    @member = Member.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def member_params
    params.require(:member).permit(:first_name,
                                   :last_name,
                                   :title,
                                   :country_of_residence,
                                   :job_title,
                                   :organisation,
                                   :link,
                                   :email
                                  )
  end
end
