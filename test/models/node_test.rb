require 'test_helper'

class NodeTest < ActiveSupport::TestCase
  def setup
    #tr for test root
    @tr = "#{Rails.root}/test/fixtures/test_folder"
  end
  
  test "cal md5" do
    md5_file_a = '7b45efce55755c97e7ca012e1e7f982d'
    md5_file_b = 'd8e6273c322fbbeb01ce333c5ea1d881'
    md5_file_c = '7f78bac06262f839899945b435ac0e32'
    
    nd = Node.create("#{@tr}/file_a")
    nd.cal_md5
    assert nd.md5_str == md5_file_a
    
    nd = Node.create("#{@tr}/file_b")
    nd.cal_md5
    assert nd.md5_str == md5_file_b
    
    nd = Node.create("#{@tr}/file_c")
    nd.cal_md5
    assert nd.md5_str == md5_file_c
  end
end
