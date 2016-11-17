% Class to create a graph object
% dim: [x y]% Dimensions of the graph
% qi: initial vertex
% q: vertex [x y]
% e: edge [x1 y1 x2 y2]
classdef AreaGraph
   properties
      Graph
      Initial
      Edges
   end
   methods
      function obj = AreaGraph(G)
      	 if nargin > 0
            obj.Graph = G;
         end
      end
      function obj = set.Initial(obj,val)
      	 if nargin > 0
            obj.Initial = val;
	    obj.Graph(val(1),val(2)) = 1;

         end
      end
      function obj = set.Edges(obj,val)
      	 if nargin > 0
            obj.Edges = [obj.Edges; val];
         end
      end
      function obj = set.GraphCoor(obj,val)
      	 if nargin > 0
	    obj.Graph(val(1),val(2)) = 1;
         end
      end

   end
end
