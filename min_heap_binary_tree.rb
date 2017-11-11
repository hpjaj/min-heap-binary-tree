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
    delete_index = tree.find_index(node)

    delete_node(delete_index)
    parent_child_check(replacement_node, delete_index)
  end

  def find(target_node)
    return nil if target_node.nil? ## guard clause

    node = nil

    tree.each do |item|
      if item == target_node
        node = item
        break
      end
    end

    node
  end

  def printf
    tree_to_string.join
  end

private

  def tree_to_string
    tree.compact.map do |item|
      # get rid of nil (investigate ways to remove nil from arrays)
      # print into a string (investigate ways to convert arrays to strings )
      item.value.to_s + ("\n")
    end
  end

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

  def index_to_swap_with_two_children(index)
    if left_child(index).value >= right_child(index).value
     (2 * index) + 1
    else
      2 * index
    end
  end

  def delete_node(delete_index)
    swap! delete_index, -1
    tree.pop
  end

  def parent_child_check(replacement_node, delete_index)
    if parent(delete_index).value > replacement_node.value
      swap! delete_index, parents_index(delete_index)
    elsif has_two_children?(delete_index)
      replacement_greater_than_children(replacement_node, delete_index)
    elsif has_only_smaller_left_child?(replacement_node, delete_index)
      swap! delete_index, left_child_index(delete_index)
    end
  end

  def has_only_smaller_left_child?(replacement_node, delete_index)
    left_child(delete_index) != nil && replacement_node.value > left_child(delete_index).value
  end

  def only_left_child_smaller?(index)
    (tree[index].value > left_child(index).value) && (right_child(index).value >= tree[index].value)
  end

  def only_right_child_smaller?(index)
    (left_child(index).value > tree[index].value) && (tree[index].value > right_child(index).value)
  end

  def left_child_larger?(index)
    left_child(index) != nil && tree[index].value > left_child(index).value
  end

  def both_children_smaller_swap(replacement_index)
    index_to_swap = index_to_swap_with_two_children(replacement_index)

    swap! replacement_index, index_to_swap_with_two_children(replacement_index)
    swap_down(tree[index_to_swap])
  end

  def two_children_swap(replacement_index)
    if only_left_child_smaller?(replacement_index)
      swap! replacement_index, left_child_index(replacement_index)
    elsif only_right_child_smaller?(replacement_index)
      swap! replacement_index, right_child_index(replacement_index)
    else
      both_children_smaller_swap(replacement_index)
    end
  end

  def has_two_children?(replacement_index)
    left_child(replacement_index) != nil && right_child(replacement_index) != nil
  end

  def swap_down(node)
    replacement_index = tree.find_index(node)

    if has_two_children?(replacement_index)
      two_children_swap(replacement_index)
    elsif left_child_larger?(replacement_index)
      swap! replacement_index, left_child_index(replacement_index)
    end
  end

  def replacement_greater_than_children(replacement_node, delete_index)
    if replacement_value_greater_than_either_child?(replacement_node, delete_index)
       swap_down(tree[delete_index])
    end
  end

  def replacement_value_greater_than_either_child?(replacement_node, delete_index)
    (replacement_node.value > left_child(delete_index).value) || (replacement_node.value > right_child(delete_index).value)
  end

  def replacement_only_left_child(replacement_index)
    if replacement_node.value > left_child(replacement_index).value
      swap! replacement_index, left_child_index(replacement_index)
    end
  end
end
