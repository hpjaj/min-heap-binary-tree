class MinHeapBinaryTree
  attr_reader :tree

  def initialize(root)
    @tree = [nil, root]
  end

  def root
    tree[1]
  end

  def insert(node)
    tree << node

    set_min_heap_state
  end

  def delete(node)
    replacement_node = tree[tree.length - 1]
    swap! node, replacement_node
    tree.pop
    # swap up
    if replacement_node > replacement_node.parent
      swap_down
    end
    if replacement_node < replacement_node.parent
      in_min_heap_state
    end
  end


  #     # find bottom most right index
  # # take that index and replace deleting index
  # # swap to get min-heap
  #   - check replace with parent
  #    swap if needed else
  #   - if replacement has 2 child
  #     if true compare two children
  #       smaller child gets swapped up
  #       if children == to each other pick left_child
  #       repeat

private

  def set_min_heap_state
    @in_min_heap_state = false

    until @in_min_heap_state do
      resolve_heap_state
    end
  end

  def resolve_heap_state
    problems = 0

    tree.each_with_index do |node, index|
      next if index == 0
      next if index == 1

      if parent(index).value > node.value
        swap! parents_index(index), index

        problems += 1
      end
    end

    any_problems? problems
  end

  # @see https://gist.github.com/JuanitoFatas/5875394
  #
  def swap!(index_a, index_b)
    tree[index_a], tree[index_b] = tree[index_b], tree[index_a]
    tree
  end

  def any_problems?(problems)
    if problems == 0
      @in_min_heap_state = true
    else
      @in_min_heap_state = false
    end
  end

  # Logic for storing nodes in a heap.
  #
  # For any node in position i,
  #   - its left child (if any) is in position 2i
  #   - its right child (if any) is in position 2i + 1
  #   - its parent (if any) is in position i/2 (use integer division)
  # @see https://www.cs.cmu.edu/~tcortina/15-121sp10/Unit06B.pdf
  #
  def left_child(index)
    tree[2 * index]
  end

  def right_child(index)
    tree[(2 * index) + 1]
  end

  def parent(index)
    tree[parents_index(index)]
  end

  def parents_index(index)
    index / 2
  end

  def swap_down(node)
    problems == 0
    if replacement_node.left_child != nil && replacement_node.right != nil
      # find lower value node.child
      swap! replacement_node, node_to_swap_with_two_children

      problems += 1
    else
      swap! replacement_node, replacement_node.left_child
      problems += 1
    end
  end

  def node_to_swap_with_two_children
    replacement_node.left_child > replacement_node.right_child ? replacement_node.right_child : replacement_node.left_child
  end
end
