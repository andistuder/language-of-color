# frozen_string_literal: true

RailsAdmin.config do |config|
  ### Popular gems integration

  ## == Devise ==
  config.authenticate_with do
    warden.authenticate! scope: :member
  end
  config.current_user_method(&:current_member)

  config.authorize_with do
    redirect_to main_app.root_path unless warden.user.is_admin?
  end

  ## == Cancan ==
  # config.authorize_with :cancan

  ## == PaperTrail ==
  # config.audit_with :paper_trail, 'User', 'PaperTrail::Version' # PaperTrail >= 3.0.0

  ### More at https://github.com/sferik/rails_admin/wiki/Base-configuration

  config.actions do
    dashboard                     # mandatory
    index                         # mandatory
    new
    export
    bulk_delete
    show
    edit
    delete
    show_in_app

    ## With an audit adapter, you can add:
    # history_index
    # history_show
  end

  config.model 'Member' do
    edit do
      configure :email do
        help 'Required.'
      end
      configure :set_password do
        help 'Required when creating a new record.'
      end
      configure :password do
        hide
      end
      configure :created_at do
        hide
      end
      configure :updated_at do
        hide
      end
      configure :password_confirmation do
        hide
      end
      configure :reset_password_token do
        hide
      end
      configure :reset_password_sent_at do
        hide
      end
      configure :remember_created_at do
        hide
      end
      configure :sign_in_count do
        hide
      end
      configure :current_sign_in_at do
        hide
      end
      configure :last_sign_in_at do
        hide
      end
      configure :current_sign_in_ip do
        hide
      end
      configure :last_sign_in_ip do
        hide
      end
    end
  end
end
