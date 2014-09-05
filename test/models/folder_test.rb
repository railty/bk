require 'test_helper'

class FolderTest < ActiveSupport::TestCase
  def setup
    #tr for test root
    @tr = "#{Rails.root}/test/fixtures/test_folder"
  end
  
  def teardown
  end
  
  test "folder create" do
    fd_a = Folder.create("#{@tr}/folder_a")
    assert fd_a != nil
    fd_b = Folder.create("#{@tr}/folder_b")
    assert fd_b != nil
    fd_c = Folder.create("#{@tr}/folder_c")
    assert fd_c != nil
    fd_d = Folder.create("#{@tr}/folder_d")
    assert fd_d == nil
  end
  
  test "create descendants" do
    nf = Folder.all.length
    nn = Node.all.length
    fd = Folder.create(@tr)
    fd.create_descendants
    
    assert Folder.all.length == nf + 6
    assert Node.all.length == nn + 24
  end
  
  test "cal md5" do
    fd = Folder.create(@tr)
    fd.create_descendants
    fd.cal_md5
      
    fd_a = Folder.where("name = ?", "#{@tr}/folder_a").first
    fd_c = Folder.where("name = ?", "#{@tr}/folder_c").first
    fd_b_ba = Folder.where("name = ?", "#{@tr}/folder_b/folder_ba").first
    fd_b_bc = Folder.where("name = ?", "#{@tr}/folder_b/folder_bc").first
      
    assert fd_a.md5_str == fd_c.md5_str
    assert fd_a.md5_str == fd_b_ba.md5_str
    assert fd_a.md5_str == fd_b_bc.md5_str
  end
end
