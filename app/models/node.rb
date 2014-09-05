class Node < ActiveRecord::Base
  belongs_to :folder
  
  def cal_md5
    if self.type=='Folder' then
      puts "xxx"
    else
      self.md5 = Digest::MD5.file(self.name).hexdigest
      self.save
    end
  end
  
  def self.create(path, folder=nil)
    if File.exist?(path) then
      nd = File.directory?(path) ? Folder.new : Node.new
      if folder==nil then
        nd.name = path
        nd.mtime = File.mtime(path)
        nd.size = File.size(path)
      else
        nd.name = path
        #nd.name = File.basename(path)
        nd.folder = folder
      end
      nd.save
      return nd
    end
    puts "cannot create node [#{path}]"
    return nil
  end
  
  def md5_str
    return 'unknown' if self.md5 == nil
    return self.md5.unpack('H*')[0]
  end
end
