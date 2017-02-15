class Post < ApplicationRecord
 validate :validations

  def validations
    if host_name.length>255 || host_email.length>255 || venue.length>255 || location.length>255 || theme.length>255
      errors.add(:base,"Input was too long.")
    end
    if self[:when]>when_its_over
      errors.add(:base,"Incorrect party time.")
    end
    if venue.length > 0 && location.length < 0
	   errors.add(:location,"Where is the party?")
    end
    if guest_names.split(',').count.to_i != numgsts.to_i
      errors.add(:guest_names,"Missing guest #{numgsts}name #{guest_names.split(',').count.to_i}")
    end
  end

  def after_save
    # clean "Harry S. Truman" guest name to "Harry S._Truman"
    # clean "Roger      Rabbit" guest name to "Roger Rabbit"
    gnames = []
    guest_names.split(',').each do |g|
      g.squeeze
      names=g.split(' ')
      gnames << "#{names[0]} #{names[1..-1].join('_')}"
    end
    guest_names = gnames
    save!
  end
end

