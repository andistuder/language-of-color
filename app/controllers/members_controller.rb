class MembersController < ApplicationController
  before_action :set_member, only: [:approve]

  def index
    if ENV['MEMBERS_DISABLED'] && !current_member.try(:is_admin?)
      redirect_to '/', notice: 'Membership page temporarily unavailable.'
    else
      @members = if params[:approved] == "false"
        Member.find_all_by_approved(false)
      else
        @users = Member.all
      end
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

  def approve
    render plain: '403 Forbidden', status: 403 && return unless current_member.try(:is_admin?)
    if @member.update_attribute(:approved, true)
      redirect_to members_path, notice: 'Member was successfully updated.'
    else
      render plain: '500 Something went wrong', status: 500
    end
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
