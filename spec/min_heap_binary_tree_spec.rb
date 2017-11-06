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

        expect(min_heap_tree.root).to eq new_node
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

  describe "#delete" do
    it "properly deletes node and keeps min heap state" do
      initial_node = Node.new 5
      min_heap_tree = MinHeapBinaryTree.new(initial_node)

      node_7 = Node.new 7
      node_3 = Node.new 3
      node_6 = Node.new 6

      min_heap_tree.insert(node_7)
      min_heap_tree.insert(node_3)
      min_heap_tree.insert(node_6)

      min_heap_tree.delete(node_6)

      expect(min_heap_tree.tree).to eq(
        [
          nil,
          node_3,
          node_7,
          initial_node
        ]
      )
    end

    it "properly deletes node and replacement greater the only left child and swaps" do
      initial_node = Node.new 4
      min_heap_tree = MinHeapBinaryTree.new(initial_node)

      node_7 = Node.new 7
      node_9 = Node.new 9
      node_6 = Node.new 6
      node_5 = Node.new 5

      min_heap_tree.insert(node_5)
      min_heap_tree.insert(node_6)
      min_heap_tree.insert(node_7)
      min_heap_tree.insert(node_9)

      min_heap_tree.delete(node_5)

      expect(min_heap_tree.tree).to eq(
        [
          nil,
          initial_node,
          node_7,
          node_6,
          node_9
        ]
      )
    end

    context "properly deletes a node and keeps min state from level 1 with 2 children" do
      it "after delete chooses proper child to swap and filters down to keep min-heap" do
        initial_node = Node.new 8
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

        min_heap_tree.insert(node_5)
        min_heap_tree.insert(node_7)
        min_heap_tree.insert(node_4)
        min_heap_tree.insert(node_6)
        min_heap_tree.insert(node_2)
        min_heap_tree.insert(node_1)
        min_heap_tree.insert(node_3)

        min_heap_tree.delete(node_3)

        expect(min_heap_tree.tree).to eq(
          [
            nil,
            node_1,
            node_5,
            node_2,
            initial_node,
            node_6,
            node_7,
            node_4
          ]
        )
      end
    end

    it "after delete it swaps with left_child and swaps again with new child to keep min-heap state" do
      initial_node = Node.new 1
      min_heap_tree = MinHeapBinaryTree.new(initial_node)

      node_5 = Node.new 5
      node_6 = Node.new 6
      node_9 = Node.new 9
      node_11 = Node.new 11
      node_8 = Node.new 8
      node_15 = Node.new 15
      node_17 = Node.new 17
      node_21 = Node.new 21

      min_heap_tree.insert(node_5)
      min_heap_tree.insert(node_6)
      min_heap_tree.insert(node_9)
      min_heap_tree.insert(node_11)
      min_heap_tree.insert(node_8)
      min_heap_tree.insert(node_15)
      min_heap_tree.insert(node_17)
      min_heap_tree.insert(node_21)

      min_heap_tree.delete(node_5)

      expect(min_heap_tree.tree).to eq(
        [
          nil,
          initial_node,
          node_9,
          node_6,
          node_17,
          node_11,
          node_8,
          node_15,
          node_21
        ]
      )
    end

    it "properly deletes a node with 2 children and picks right_child to swap" do
      initial_node = Node.new 1
      min_heap_tree = MinHeapBinaryTree.new(initial_node)

      node_5 = Node.new 5
      node_6 = Node.new 6
      node_9 = Node.new 9
      node_7 = Node.new 7
      node_8 = Node.new 8
      node_15 = Node.new 15
      node_17 = Node.new 17
      node_21 = Node.new 21

      min_heap_tree.insert(node_5)
      min_heap_tree.insert(node_6)
      min_heap_tree.insert(node_9)
      min_heap_tree.insert(node_7)
      min_heap_tree.insert(node_8)
      min_heap_tree.insert(node_15)
      min_heap_tree.insert(node_17)
      min_heap_tree.insert(node_21)

      min_heap_tree.delete(node_5)

      expect(min_heap_tree.tree).to eq(
        [
          nil,
          initial_node,
          node_7,
          node_6,
          node_9,
          node_21,
          node_8,
          node_15,
          node_17
        ]
      )
    end

    it "properly deletes a node with 2 children that are equal" do
      initial_node = Node.new 1
      min_heap_tree = MinHeapBinaryTree.new(initial_node)

      node_5 = Node.new 5
      node_6 = Node.new 6
      node_9 = Node.new 9
      node_11 = Node.new 11
      node_8 = Node.new 8
      node_15 = Node.new 15
      node_17 = Node.new 17
      node_21 = Node.new 21

      min_heap_tree.insert(node_5)
      min_heap_tree.insert(node_6)
      min_heap_tree.insert(node_9)
      min_heap_tree.insert(node_9)
      min_heap_tree.insert(node_8)
      min_heap_tree.insert(node_15)
      min_heap_tree.insert(node_17)
      min_heap_tree.insert(node_21)

      min_heap_tree.delete(node_5)

      expect(min_heap_tree.tree).to eq(
        [
          nil,
          initial_node,
          node_9,
          node_6,
          node_9,
          node_21,
          node_8,
          node_15,
          node_17
        ]
      )
    end

    it "properly deletes a node and swaps up if child is smaller then parent" do
      initial_node = Node.new 1
      min_heap_tree = MinHeapBinaryTree.new(initial_node)

      node_9 = Node.new 9
      node_19 = Node.new 19
      node_17 = Node.new 17
      node_11 = Node.new 11
      node_22 = Node.new 22
      node_27 = Node.new 27
      node_21 = Node.new 21
      node_33 = Node.new 33

      min_heap_tree.insert(node_9)
      min_heap_tree.insert(node_22)
      min_heap_tree.insert(node_17)
      min_heap_tree.insert(node_11)
      min_heap_tree.insert(node_33)
      min_heap_tree.insert(node_27)
      min_heap_tree.insert(node_21)
      min_heap_tree.insert(node_19)

      min_heap_tree.delete(node_33)

      expect(min_heap_tree.tree).to eq(
        [
          nil,
          initial_node,
          node_9,
          node_19,
          node_17,
          node_11,
          node_22,
          node_27,
          node_21
        ]
      )
    end
  end

  # describe "#print" do
  #   it "properly prints the whole tree" do
  #     initial_node = Node.new 5
  #     min_heap_tree = MinHeapBinaryTree.new(initial_node)
  #
  #     node_7 = Node.new 7
  #     node_3 = Node.new 3
  #     node_9 = Node.new 9
  #     node_1 = Node.new 1
  #     node_2 = Node.new 2
  #     node_4 = Node.new 4
  #     node_8 = Node.new 8
  #
  #     min_heap_tree.print
  #
  #     expect(min_heap_tree.tree).to eq(
  #       [
  #         nil,
  #         node_3,
  #         node_2,
  #         node_8,
  #         node_7,
  #         initial_node,
  #         node_4,
  #         node_9
  #       ]
  #     )
  #   end
  # end
  #
  # describe "#find" do
  #   it "finds a node in the tree" do
  #     initial_node = Node.new 3
  #     min_heap_tree = MinHeapBinaryTree.new(initial_node)
  #
  #     node_2 = Node.new 2
  #     node_7 = Node.new 7
  #
  #     min_heap_tree.insert(node_2)
  #     min_heap_tree.insert(node_7)
  #
  #     min_heap_tree.find(node_7)
  #
  #     expect(min_heap_tree.tree).to eq(
  #       [
  #         node_7
  #       ]
  #     )
  #   end
  # end
end
