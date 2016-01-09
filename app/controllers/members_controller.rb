class MembersController < ApplicationController
  before_action :authorize_and_set_member, only: [:show, :edit, :update, :destroy]

  def index
    if ENV['MEMBERS_DISABLED'] && !current_member.try(:is_admin?)
      redirect_to '/', notice: 'Membership page temporarily unavailable.'
    else
      set_members
    end
  end

  def edit
    @member
  end

  def update
    if @member.update(member_params)
      redirect_to @member, notice: 'Member was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @member.destroy
    redirect_to members_url, notice: 'Membership cancelled: your data was successfully destroyed.'
  end

  private

  def authorize_and_set_member
    @member = Member.find(params[:id])
    render plain: '403 Forbidden', status: 403 unless current_member.id == @member.try(:id)
  end

  def set_members
    @members = Member.all
  end

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
