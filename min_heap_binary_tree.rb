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

    replacement_node = tree[-1]
    x = tree.find_index(node)
    swap! x, -1
    tree.pop
    # swap up
    if parent(x).value > replacement_node.value
      swap! x, parents_index(x)
    elsif left_child(x) != nil && right_child(x) != nil
      if (replacement_node.value > left_child(x).value) || (replacement_node.value > right_child(x).value)
         swap_down(tree[x])
      end
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

def find(node)
  tree.each do |item|
    # byebug
    if item == node
      p "#{item} is in the tree"
    end
  end
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

  def left_child_index(index)
    index * 2
  end

  def right_child_index(index)
    (index * 2) + 1
  end

  def index_to_swap_with_two_children(x)
    if right_child(x).value <= left_child(x).value
      (2 * x) + 1
    else
      2 * x
    end
  end

  def swap_down(node)
    x = tree.find_index(node)
    if left_child(x) != nil && right_child(x) != nil
      if (tree[x].value <= left_child(x).value) && (tree[x].value <= right_child(x).value)
        # do nothing
      elsif (left_child(x).value < tree[x].value) && (tree[x].value <= right_child(x).value)
        swap! x, left_child_index(x)
      elsif (tree[x].value < left_child(x).value) && (right_child(x).value < tree[x].value)
        swap! x, right_child_index(x)
      else
        y = index_to_swap_with_two_children(x)
        swap! x, index_to_swap_with_two_children(x)
        swap_down(tree[y])
      end
    elsif left_child(x) != nil && tree[x].value > left_child(x).value
        swap! x, left_child_index(x)
    end
  end
end
