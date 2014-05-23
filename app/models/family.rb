require 'digest/sha1'

class Family < ActiveRecord::Base
  has_many :people

  attr_accessor :new_password

  before_save :hash_password

  def hash_password
    password =  Digest::SHA1.hexdigest @new_password
    self.password = password
  end

  def self.authenticate(family_name, password)
    pwd = Digest::SHA1.hexdigest(password)
    fam = Family.where(:family_name => family_name).
                 where(:password => pwd)
  end

end
