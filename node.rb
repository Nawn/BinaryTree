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

  def self.build_tree(input_array)
  	ary = input_array.clone #Cloned arry to avoid error
  	primary = nil #declare this variable in this scope
  	ary.shuffle.each_with_index do |element, index|
  		if index.zero? #If it's the first one
  			primary = Node.new(element) #Make it the primary node
  			next #and go to the next one
  		end
  		primary.add_node(element) #Add the remainder of them to the primary node
  	end
  	primary #Then return the finished tree
  end

  def initialize(value=0, parent=nil, l_node=nil, r_node=nil)
    @value = value
    @parent = parent
    @l_child = l_node
    @r_child = r_node
  end

  def depth_first(search_value)
    if @value != search_value && @l_child.nil? && @r_child.nil? #If this isn't it, and there are no kids
      return nil
    end

    return self if @value == search_value #Return this node, if it's the correct one

    @l_child.depth_first(search_value) unless @l_child.nil? #If it hasn't returned(because it wasn't found) Check the children
    @r_child.depth_first(search_value) unless @r_child.nil?
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

node1 = Node.build_tree(Array(1..20))
node1.display
puts "Now to search it!"
node2 = node1.depth_first(16)
node2.display