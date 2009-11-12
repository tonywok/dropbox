class Hash # :nodoc:
  def symbolize_keys # :nodoc:
    inject({}) do |options, (key, value)|
      options[(key.to_sym rescue key) || key] = value
      options
    end
  end unless method_defined?(:symbolize_keys)

  def symbolize_keys! # :nodoc:
    self.replace(self.symbolize_keys)
  end unless method_defined?(:symbolize_keys!)

  def symbolize_keys_recursively # :nodoc:
    hsh = symbolize_keys
    hsh.each { |k, v| hsh[k] = v.symbolize_keys_recursively if v.kind_of?(Hash) }
    return hsh
  end

  def to_struct # :nodoc:
    Struct.new(*keys).new(*values)
  end unless method_defined?(:to_struct)

  def to_struct_recursively # :nodoc:
    hsh = dup
    hsh.each { |k, v| hsh[k] = v.to_struct_recursively if v.kind_of?(Hash) }
    return hsh.to_struct
  end
end
