class Artist
  attr_reader :id, :name, :born, :died, :country
  def initialize(attributes)
    @id = attributes[:id]
    @name = attributes[:name]
    @born = attributes[:born]
    @died = attributes[:died]
    @country = attributes[:country]
  end

  def ==(other)
    return false unless self.class == other.class
    self.instance_variables.each do |instance_var|
      instance_var = instance_var.to_s[1..-1]
      return false unless self.send(instance_var) == other.send(instance_var)
    end
    true
  end
end
