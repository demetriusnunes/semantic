class Uri < String

  def self.join(base, tail)
    uri = base.clone
    uri << "/" unless ['#', '/'].include?(uri[-1,1])
    return new("#{uri}#{tail}")
  end
  
end
