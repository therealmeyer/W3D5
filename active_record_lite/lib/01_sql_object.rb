require_relative 'db_connection'
require 'active_support/inflector'
# NB: the attr_accessor we wrote in phase 0 is NOT used in the rest
# of this project. It was only a warm up.

class SQLObject
  def self.columns
    return @columns if @columns
    columns = DBConnection.execute2(<<-SQL)
      SELECT
        *
      FROM
        #{self.table_name}
    SQL
    @columns = columns[0].map { |column| column.to_sym }
  end

  def self.finalize!
    self.columns.each do |name|
      define_method(name) do
        @attributes[name]
      end
      define_method("#{name}=") do |arg|
        self.attributes[name] = arg
      end

    end
  end

  def self.table_name=(table_name)
    @table_name = table_name
  end

  def self.table_name
    class_name = self.name
    result = ''
    class_name.each_char.with_index do |chr, idx|
      unless chr == chr.downcase || idx == 0
        result += '_'
      end
      result += chr.downcase
    end
    result += 's'
    @table_name = result
  end

  def self.all
    # ...
  end

  def self.parse_all(results)
    # ...
  end

  def self.find(id)
    # ...
  end

  def initialize(params = {})
    params.each do |k,v|
      k = k.to_sym
      unless self.columns.include?(k)
        raise 'not a column'
      end
      self.send("#{k}=", v)
    end

  end

  def attributes
    @attributes ||= {}
  end

  def attribute_values
    # ...
  end

  def insert
    # ...
  end

  def update
    # ...
  end

  def save
    # ...
  end
end

class ChildCare < SQLObject

end
