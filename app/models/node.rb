class Node < ActiveRecord::Base
  has_many :children, class_name: "Node", foreign_key: "parent_id"
  belongs_to :parent, class_name: "Node"#, foreign_key: "manager_id"

  def self.create_node(path, folder=nil)
    if File.exist?(path) then
      nd = self.new
      
      #nd.name = File.basename(path)
      nd.name = path
      nd.mtime = File.mtime(path)
      nd.parent = folder

      if File.directory?(path) then
        nd.is_folder = true
      else
        nd.is_folder = false
        nd.size = File.size(path)
      end

      nd.save
      return nd
    else
      puts "cannot create node [#{path}]"
      return nil
    end
  end
  
  def create_descendants
    return if not self.is_folder
    
    yield 'stage 1', 0 if block_given?
    self.create_children
    yield 'stage 2', 0 if block_given?
    self.cal_size
    yield 'stage 3', 0 if block_given?
    self.cal_md5
  end
  
  def create_children
    return if not self.is_folder
    
    ns = Dir.glob(self.name+'/*')
    ns.delete('.')
    ns.delete('..')
    ns.sort!
    
    ns.each do |child|
      nd = Node.create_node(child, self)
      #puts nd.name
      if nd.is_folder then
        nd.create_children
      end
    end
  end
  
  def cal_size
    sz = 0
    self.children.each do |child|
      child.cal_size if child.size == nil
      sz = sz + child.size
    end
    
    self.size = sz
    self.save
  end

  def cal_md5
    if self.is_folder then
      md5 = Digest::MD5.new
      self.children.each do |child|
        child.cal_md5 if child.md5 == nil
        md5 << child.md5
      end
      #self.md5 = md5.digest.force_encoding('utf-8')
      self.md5 = md5.hexdigest
      self.save
    else
      self.md5 = Digest::MD5.file(self.name).hexdigest
      self.save
    end
  end

  def md5_str
    return 'unknown' if self.md5 == nil
    return self.md5
    #if use save digest intead of hexdigest, use this to convert the binary to string
    #return self.md5.unpack('H*')[0]
  end

  def self.top(n=25)
    sql = "select md5, size*(count(*)-1) size from nodes group by md5 having count(*)>1 order by size desc limit #{n};"
    result = self.connection.execute(sql)
    mds = []
    result.each do |r|
      mds << {:md5=>r[0], :size=>r[1]}
    end
    return mds
  end
end
