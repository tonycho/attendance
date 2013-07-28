class Host < ActiveRecord::Base
  has_and_belongs_to_many :conferences

  HOST_TITLES = %w(Mr Mrs Miss )


end
