require 'md5'

module UUID

  def UUID.generate!
    MD5.hexdigest(Time.now.to_i.to_s + rand.to_s + self.__id__.to_s)
  end
  
end