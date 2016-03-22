class Node
  attr_accessor :value,
                :parent,
                :l_child,
                :r_child

  def self.sorted?(input_array)
    input_array.each_with_index do |element, index|
      next if index.zero?

      return false if element < input_array[index-1] #Returns false if this element is smaller than last
    end
    true #If it got through all of them, without returning false, it's sorted
  end

  def initialize(value=0, parent=nil, l_node=nil, r_node=nil)
    @value = value
    @parent = parent
    @l_child = l_node
    @r_child = r_node
  end

  def display(tab_number=0)
    puts "#{"\t" * tab_number}Value: #{@value}"
    @l_child.display(tab_number+1) unless @l_child.nil? #Unless there's nothing there, show children with depth(tabs)
    @r_child.display(tab_number+1) unless @r_child.nil?
  end

  def add_node(input_node)
    input_node = Node.new(input_node) unless input_node.is_a? Node #Make a node out of it unless it's already a node

    return false if input_node.value == @value #Return false if it equals, because no duplicates

    if input_node.value < @value #If the value is less than our value
      if @l_child.nil? #check to see if we already have a left child node
        input_node.parent = self #if we don't set this input's parent to us
        @l_child = input_node #and then set our left child to it
        return true #return true, because we successfully added the node
      else
        @l_child.add_node(input_node) #if a left child already exists, add this value to that sub-tree
      end
    else
      if @r_child.nil? #if it's empty
        input_node.parent = self #set the node's parent to us
        @r_child = input_node #then make it our child
        return true #return true, so we know it was successfully added
      else
        @r_child.add_node(input_node) #if it's not empty, add it to the existing node
      end
    end
  end
end

=begin
  *Need to create the #build_tree method:
    +It will take an array as a param, and then shuffle it.
    +It will then set the first in the array as the Primary node
    +The rest will be #add_node() to the primary, and will return the primary node(root of the tree)
    
  *Need to create the breadth, and depth searches (Check the website for specific instructions)
=end