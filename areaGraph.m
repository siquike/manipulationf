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
      % Constructor Method % Constructs object
      function obj = AreaGraph(G)
      	 if nargin > 0
            obj.Graph = G;
            obj.Initial = [];
            obj.Edges = [];
         end
      end
      function obj = init(obj,val)
      	 if nargin > 0
            obj.Graph(val(1),val(2)) = 1;
            obj.Initial = val;
        end
      end
      function obj = addEdges(obj,val)
      	 if nargin > 0
            obj.Edges = [obj.Edges; val];
         end
      end
      function obj = addVertex(obj,val)
      	 if nargin > 0
	    obj.Graph(val(1),val(2)) = 1;
         end
      end

   end
end