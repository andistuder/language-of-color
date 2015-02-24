class PagesController < ApplicationController
  def home
    render layout: 'home'
  end
  def about
  end
  def bibliography
  end
  def contact
    @contact_form = ContactForm.new
  end
  def resources
  end
  def news
  end
  def disclaimner
  end
end
