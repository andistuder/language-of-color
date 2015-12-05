class MembersController < ApplicationController
  before_action :set_member, only: [:approve, :destroy]

  def index
    if ENV['MEMBERS_DISABLED'] && !current_member.try(:is_admin?)
      redirect_to '/', notice: 'Membership page temporarily unavailable.'
    else
      set_members
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

  def destroy
    @member.destroy
    respond_to do |format|
      format.html { redirect_to members_url, notice: 'Member was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def set_member
    @member = Member.find(params[:id])
  end

  def set_members
    @members = if params[:approved] == 'false'
                 Member.find_all_by_approved(false)
               else
                 Member.all
               end
  end
end
