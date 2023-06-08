require 'xml'

class Astronaut < ApplicationRecord
  validates :first_name, :last_name, presence: true
  validates :age, numericality: { only_integer: true, allow_nil: true }

  def self.export_to_xml
    document = XML::Document.new
    document.root = XML::Node.new('astronauts')

    Astronaut.find_each(batch_size: 100000) do |astronaut|
      astronaut.build_astronaut_xml(document)
    end

    document.to_s
  end

  private

  def build_astronaut_xml(document, astronaut)
    document.root << elem = XML::Node.new('astronaut')

    elem['first_name'] = astronaut.first_name
    elem['last_name'] = astronaut.last_name
    elem['age'] = astronaut.age.to_s
  end
end
