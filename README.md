# Balanced Binary Search Tree in Ruby

This project implements a balanced binary search tree (BST) in Ruby. The tree supports standard BST operations such as insertion, deletion, searching, and different types of tree traversals (level order, inorder, preorder, and postorder). It also includes methods to determine the height and depth of nodes, check if the tree is balanced, and rebalance the tree when necessary.

## Features

- **Node Class**
  - Holds the node's data and references to its left and right children.
  - Implements the `Comparable` module to enable node comparison based on the stored data.

- **Tree Class**
  - **Initialization:** 
    - Accepts an array of integers, removes duplicates, and sorts them.
    - Builds a balanced BST using the middle element as the root (recursive approach).
  - **Insertion & Deletion:** 
    - Recursive insertion that maintains tree order.
    - Recursive deletion that handles cases with no child, one child, and two children (using the inorder successor).
  - **Searching:** 
    - Recursive find method to locate nodes.
  - **Traversals:** 
    - Level Order (Breadth-First Search)
    - Inorder (Left, Root, Right)
    - Preorder (Root, Left, Right)
    - Postorder (Left, Right, Root)
  - **Height & Depth:** 
    - Computes the height of a node (number of edges to the deepest leaf).
    - Computes the depth of a node (number of edges from the root to the node).
  - **Balance Checking & Rebalancing:**
    - Checks that each node's left and right subtree heights differ by no more than one.
    - Rebuilds the tree into a balanced state using an inorder traversal.
