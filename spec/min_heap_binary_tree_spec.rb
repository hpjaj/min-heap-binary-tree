RSpec.describe MinHeapBinaryTree do
  describe "#tree" do
    it "should create a tree with a root node in the index 1 position" do
      initial_node  = Node.new 10
      min_heap_tree = MinHeapBinaryTree.new(initial_node)

      expect(min_heap_tree.tree).to eq [nil, initial_node]
      expect(min_heap_tree.root).to eq min_heap_tree.tree[1]
    end
  end

  describe "#insert" do
    context "when the root is <= the new node" do
      it "the passed in node should be the root's left child" do
        initial_node  = Node.new 10
        new_node      = Node.new 15
        min_heap_tree = MinHeapBinaryTree.new(initial_node)

        min_heap_tree.insert(new_node)

        expect(min_heap_tree.tree).to eq [nil, initial_node, new_node]
      end
    end

    context "when the root is greater than the new node" do
      it "the parent should swap positions with the new node" do
        initial_node  = Node.new 10
        new_node      = Node.new 5
        min_heap_tree = MinHeapBinaryTree.new(initial_node)

        min_heap_tree.insert(new_node)

        expect(min_heap_tree.tree).to eq [nil, new_node, initial_node]
      end
    end

    context "when inserting multiple unordered nodes" do
      it "should be at min heap state" do
        initial_node  = Node.new 5
        min_heap_tree = MinHeapBinaryTree.new(initial_node)

        node_9 = Node.new 9
        node_3 = Node.new 3
        node_4 = Node.new 4
        node_6 = Node.new 6
        node_2 = Node.new 2
        node_7 = Node.new 7
        node_1 = Node.new 1
        node_8 = Node.new 8
        node_5 = Node.new 5

        min_heap_tree.insert(node_9)
        min_heap_tree.insert(node_3)
        min_heap_tree.insert(node_4)
        min_heap_tree.insert(node_6)
        min_heap_tree.insert(node_2)
        min_heap_tree.insert(node_7)
        min_heap_tree.insert(node_1)
        min_heap_tree.insert(node_8)
        min_heap_tree.insert(node_5)

        expect(min_heap_tree.tree).to eq(
          [
            nil,
            node_1,
            node_2,
            node_3,
            node_4,
            node_5,
            initial_node,
            node_7,
            node_9,
            node_8,
            node_6
          ]
        )
      end
    end
  end
end
