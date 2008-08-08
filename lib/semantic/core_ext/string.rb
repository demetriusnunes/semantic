class String
  def constantize
    Object.module_eval("::#{self}")
  end
  
  def demodulize
    self =~ /(.+)\:\:(.+)/ ? $2 : self
  end
  
end
