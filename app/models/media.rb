require 'sinatra/base'
require 'fileutils'

class Media < ActiveRecord::Base
  belongs_to :conference
  belongs_to :media_type

  FILE_DIRECTORY = "files"

  def self.upload_file params_file
    if params_file
      filename = params_file[:filename]
      file = params_file[:tempfile]
      directory = "public/#{FILE_DIRECTORY}"

      File.open(File.join(directory, filename), 'wb') do |f|
        f.write file.read
      end
      return filename

    else
      return nil
    end
  end

  def media_type_desc
    self.media_type.try(:name)
  end

  def get_file_path
    "/#{FILE_DIRECTORY}/" + location
  end
end
