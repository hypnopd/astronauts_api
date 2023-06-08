require 'xml'

class ImportAstronautsJob < ApplicationJob
  queue_as :default

  def perform(file_path)
    chunk_size = 100000
    batch = []
    count = 0

    reader = XML::Reader.file(file_path, encoding: XML::Encoding::UTF_8)

    while reader.read
      if reader.node_type == XML::Reader::TYPE_ELEMENT && reader.name == 'astronaut'
        chunk = {}
        while reader.name != 'age'
          reader.move_to_next_attribute
          chunk[reader.name.to_sym] = reader.value
        end

        batch << chunk
        count += 1

        if count >= chunk_size
          puts "Processing #{count} users"
          process_batch(batch)
          batch = []
          count = 0
        end
      end
    end

    process_batch(batch) unless batch.empty?
  end

  private

  def process_batch(batch)
    batch.map do |chunk|
      Astronaut.new(
        first_name: chunk[:first_name],
        last_name: chunk[:last_name],
        age: chunk[:age].to_i
      )
    end
    Astronaut.import batch
  end
end
