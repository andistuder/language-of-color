# frozen_string_literal: true

class Resource < ActiveRecord::Base
  has_attached_file :file,
                    s3_permissions: :private

  # TODO: any type allowed
  validates_attachment_content_type :file, content_type: %r{\A(application/(pdf|zip))\Z}
end
