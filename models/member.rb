class Member < ActiveRecord::Base
  has_and_belongs_to_many :events

  def self.selectautocomplete term
    members = Member.select(:first_name).where(:last_name => term)

    # Partial match
    if members.empty?
      members = Member.where("last_name like '%#{term}%'").pluck(:first_name)
    end
    return members
  end
end
