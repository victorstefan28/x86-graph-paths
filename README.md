# x86-graph-paths
Determine number of paths between two vertices of a directed graph using x86 assembly(AT&amp;T syntax).

The number of paths of length k in the directed graph G between (i,j) ∈ V^2 is obtained by calculating A^k and checking the value on the (i,j) position in the result, which is the exact number of paths of length k between i and j in the directed graph. 
A = Adjacency matrix of graph G. 
