class AttrAccessorObject
  def self.my_attr_accessor(*names)
    names.each do |name|
      define_method(name) do
        puts self
        instance_variable_get("@#{name.to_s}" )

      end
      define_method("#{name}=") do |arg|
        instance_variable_set("@#{name.to_s}",arg)
      end
    end
  end
end
