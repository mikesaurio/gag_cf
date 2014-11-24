class Post < ActiveRecord::Base

# attr_accessible :photo, :titulo

 after_save  :guardar_foto

 FOTOS =  File.join Rails.root , 'public', 'photo_store'

def  photo (file_data)
  if not file_data.blank?
      @file_data = file_data
      self.extension = file_data.original_filename.split('.').last.downcase
  else
    puts "nada"
  end
end


def photo_filename
  File.join FOTOS, "#{id}.#{extension}"
end

def photo_path
  "/photo_store/#{id}.#{extension}"
end

def has_photo?
  FIle.exists? photo_filename
end


 private 
 def  guardar_foto
  if @file_data
    FileUtils.mkdir_p FOTOS
    File.open(foto_filename, 'wb') do | f | 
      f.write(@file_data.read)
    end
    @file_data= nil 
 end
end


end
