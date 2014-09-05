class Folder < Node
  has_many :nodes
  
  def children
    ns = Dir.glob(self.name+'/*')
    ns.delete('.')
    ns.delete('..')
    ns.sort!
    return ns
  end
        
  def create_descendants
    self.children.each do |child|
      nd = Node.create(child, self)
      #puts nd.name
      if nd.type == 'Folder' then
        nd.create_descendants
      end
    end
  end
  
  def cal_md5
    md5 = Digest::MD5.new
    
    self.nodes.each do |child|
      child.cal_md5 if child.md5 == nil
      md5 << child.md5
    end
    #self.md5 = md5.digest.force_encoding('utf-8')
    self.md5 = md5.hexdigest
    self.save
  end
end
