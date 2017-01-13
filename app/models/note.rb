class Note
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Elasticsearch

  extend Enumerize

  elasticsearch!

  field :title, type: String
  field :content, type: String

  field :privacy, type: String
  enumerize :privacy, in: [:public, :private], default: :private

  field :visualizations, type: Integer, default: 0
  field :first_visualization, type: DateTime

  field :status, type: String
  enumerize :status, in: [:active, :inactive, :draft], default: :draft

  belongs_to :user

end
