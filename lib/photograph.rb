class Photograph
  attr_reader :id, :name, :artist_id, :year
  def initialize(attributes)
    @id = attributes[:id]
    @name = attributes[:name]
    @artist_id = attributes[:artist_id]
    @year = attributes[:year]
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
