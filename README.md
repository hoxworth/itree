# Intervals::Tree

An interval tree used to find interval inclusion for arbitrary points and ranges. This library utilizes an augmented AVL tree for `O(logn)` insertion, removal, and querying.

## Installation

From rubygems.org:

```
gem install itree
```

From the git repo:

```
$ gem build itree.gemspec
$ gem install json-schema-0.1.1.gem
```

# Usage

### Insertion

Insertions of ranges can be made with any type that defines `<=>`, `<`, `>`, and `==` operators. Insertions can be accompanied by an optional data object that will be saved along with the range.

```ruby
require 'rubygems'
require 'itree'

tree = Intervals::Tree.new
t.insert(0,100)
t.insert(50,500)
t.insert(90,200,"this data is saved with the range")
```

### Querying

A *stabbing query* returns an array of `Intervals::Node` ranges that fully contain the desired point or range.

```ruby
require 'rubygems'
require 'itree'

tree = Intervals::Tree.new
t.insert(0,100)
t.insert(50,500)

results = t.stab(5)
results.length         # => 1
results[0].scores      # => [0,100]

results = t.stab(55)
results.length         # => 2
results[0].scores      # => [0,100]
results[1].scores      # => [50,500]

results = t.stab(10,20)
results.length         # => 1
results[0].scores      # => [0,100]

results = t.stab(10,200)
results.length         # => 0
```

### Removal

Ranges are removed by directly removing the desired range.

```ruby
require 'rubygems'
require 'itree'

tree = Intervals::Tree.new
t.insert(0,100)
t.insert(50,500)
t.size                  # => 2

t.remove(0,100)
t.size                  # => 1
```

# See Also
* [Interval Trees on Wikipedia](http://en.wikipedia.org/wiki/Interval_tree)
* [interval-tree gem](https://github.com/misshie/interval-tree) by @misshie - An implementation that utilizes Ruby ranges but does not allow dynamic insertion and removal on an existing object.

