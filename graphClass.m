% Class to create a graph object
% dim: [x y]% Dimensions of the graph
% qi: initial vertex
% q: vertex [x y]
% e: edge [x1 y1 x2 y2]
classdef areaGraph
   properties
      init
      add_vertex
      add_edge

   end
   methods
      function G = creategraph(dim)
         if nargin > 0
            G = zeros(dim(1),dim(2));
         end
      end
      function G = init(qi)
         if nargin > 0
            G.init = qi;
	    G(G.init(1),G.init(2)) = 1;	 
         end
      end
      function G = add_vertex(q)
         if nargin > 0
	    G.add_vertex = q;	 
            G(G.add_vertex(1),G.add_vertex(2)) = 1;
         end
      end
      function G = add_edge(e)
         if nargin > 0
	    G.add_edge =[G.add_edge; e];	 
         end
      end

   end
end
