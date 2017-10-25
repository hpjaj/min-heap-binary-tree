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
      # we can this one because it is nil
      next if index == 0
      # we skip this one because root does not have a parent
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
end
