class String
  def constantize
    Object.module_eval("::#{self}")
  end
end
