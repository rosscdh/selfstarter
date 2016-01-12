class Document < ActiveRecord::Base
  belongs_to :customer

  mount_uploader :document, ProjectDocumentUploader
end
