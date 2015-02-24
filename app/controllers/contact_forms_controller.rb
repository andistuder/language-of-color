# require 'mail_form'

class ContactFormsController < ApplicationController
  def create
    begin
      @contact_form = ContactForm.new(params[:contact_form])
      @contact_form.request = request
      if @contact_form.deliver
        flash.now[:notice] = 'Thank you for your message!'
        render "pages/contact"
      else
        flash.now[:error] = 'Something went wrong and your message was not sent. Please try again later or email us on language-of-color@aic-color.org'
        render "pages/contact"
      end
    end
  end
end
