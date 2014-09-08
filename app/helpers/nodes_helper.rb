module NodesHelper
  def node_type(node)
    return node.is_folder ? 'Y' : 'N'
  end
end
