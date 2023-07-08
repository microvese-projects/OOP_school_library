require 'json'
require 'fileutils'

def update(data, name)
  File.write("files/#{name}.json", JSON.pretty_generate(data))
end

def save(data_array, name)
  return if data_array.empty?

  FileUtils.mkdir_p('files')
  update(data_array, name)
end
