require 'test_helper'

class NodeTest < ActiveSupport::TestCase
  def setup
    #tr for test root
    @tr = "#{Rails.root}/test/fixtures/test_folder"
  end
  
  def teardown
  end
  
  test "node create" do
    f_a = Node.create_node("#{@tr}/file_a")
    assert f_a != nil
    assert f_a.is_folder == false
    assert f_a.size == File.size("#{@tr}/file_a")    
    
    f_b = Node.create_node("#{@tr}/file_b")
    assert f_b != nil
    assert f_b.is_folder == false
    assert f_b.size == File.size("#{@tr}/file_b")
    
    f_c = Node.create_node("#{@tr}/file_c")
    assert f_c != nil
    assert f_c.is_folder == false
    assert f_c.size == File.size("#{@tr}/file_c")

    fd_a = Node.create_node("#{@tr}/folder_a")
    assert fd_a != nil
    assert fd_a.is_folder == true
    assert fd_a.size == nil
    
    fd_b = Node.create_node("#{@tr}/folder_b")
    assert fd_b != nil
    assert fd_b.is_folder == true
    assert fd_b.size == nil
    
    fd_c = Node.create_node("#{@tr}/folder_c")
    assert fd_c != nil
    assert fd_c.is_folder == true
    assert fd_c.size == nil
    
    fd_d = Node.create_node("#{@tr}/folder_d")
    assert fd_d == nil
  end

  test "create children" do
    nf = Node.where("is_folder = true").length
    nn = Node.all.length
    
    fd = Node.create_node(@tr)
    fd.create_children
    
    assert Node.where("is_folder = true").length == nf + 6
    assert Node.all.length == nn + 24
  end

  test 'cal size' do
    fd = Node.create_node(@tr)
    fd.create_children
    fd.cal_size
    fd_a = Node.where("name = ?", "#{@tr}/folder_a").first
    assert fd_a.size == 21
    fd_c = Node.where("name = ?", "#{@tr}/folder_c").first
    assert fd_c.size == 21
    fd_b = Node.where("name = ?", "#{@tr}/folder_b").first
    assert fd_b.size == 63
  end

  test "cal md5" do
    fd = Node.create_node(@tr)
    fd.create_children
    fd.cal_md5
      
    md5_file_a = '7b45efce55755c97e7ca012e1e7f982d'
    md5_file_b = 'd8e6273c322fbbeb01ce333c5ea1d881'
    md5_file_c = '7f78bac06262f839899945b435ac0e32'
    
    file_a = Node.where("name = ?", "#{@tr}/file_a").first
    assert file_a.md5_str == md5_file_a
    
    file_b = Node.where("name = ?", "#{@tr}/file_b").first
    assert file_b.md5_str == md5_file_b

    file_c = Node.where("name = ?", "#{@tr}/file_c").first
    assert file_c.md5_str == md5_file_c

    fd_a = Node.where("name = ?", "#{@tr}/folder_a").first
    fd_b = Node.where("name = ?", "#{@tr}/folder_b").first
    fd_c = Node.where("name = ?", "#{@tr}/folder_c").first
    fd_b_ba = Node.where("name = ?", "#{@tr}/folder_b/folder_ba").first
    fd_b_bc = Node.where("name = ?", "#{@tr}/folder_b/folder_bc").first
      
    assert fd_a.md5_str == fd_c.md5_str
    assert fd_a.md5_str == fd_b_ba.md5_str
    assert fd_a.md5_str == fd_b_bc.md5_str
  end

  test "create descendants" do
    fd = Node.create_node(@tr)
    fd.create_descendants
      
    md5_file_a = '7b45efce55755c97e7ca012e1e7f982d'
    md5_file_b = 'd8e6273c322fbbeb01ce333c5ea1d881'
    md5_file_c = '7f78bac06262f839899945b435ac0e32'
    
    file_a = Node.where("name = ?", "#{@tr}/file_a").first
    assert file_a.md5_str == md5_file_a
    
    file_b = Node.where("name = ?", "#{@tr}/file_b").first
    assert file_b.md5_str == md5_file_b

    file_c = Node.where("name = ?", "#{@tr}/file_c").first
    assert file_c.md5_str == md5_file_c

    fd_a = Node.where("name = ?", "#{@tr}/folder_a").first
    fd_b = Node.where("name = ?", "#{@tr}/folder_b").first
    fd_c = Node.where("name = ?", "#{@tr}/folder_c").first
    fd_b_ba = Node.where("name = ?", "#{@tr}/folder_b/folder_ba").first
    fd_b_bc = Node.where("name = ?", "#{@tr}/folder_b/folder_bc").first
      
    assert fd_a.md5_str == fd_c.md5_str
    assert fd_a.md5_str == fd_b_ba.md5_str
    assert fd_a.md5_str == fd_b_bc.md5_str

    assert fd_a.size == 21
    assert fd_b.size == 63    
    assert fd_c.size == 21
  end

  test "top" do
    fd = Node.create_node(@tr)
    fd.create_descendants
    mds = Node.top(5)
    assert true
  end
  
end
