class MembersController < ApplicationController
  before_action :set_member, only: [:approve]

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

  def approve
    render plain: '403 Forbidden', status: 403 && return unless current_member.try(:is_admin?)
    if @member.update_attribute(:approved, true)
      redirect_to members_path, notice: 'Member was successfully updated.'
    else
      render plain: '500 Something went wrong', status: 500
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_member
    @member = Member.find(params[:id])
  end
end
