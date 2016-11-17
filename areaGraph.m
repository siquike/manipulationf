% Class to create a graph object
% dim: [x y]% Dimensions of the graph
% qi: initial vertex
% q: vertex [x y]
% e: edge [x1 y1 x2 y2]
classdef AreaGraph
   properties
      Initial
   end
   methods
      function obj = AreaGraph(val)
      	 if nargin > 0
            obj.Initial = val;
         end
      end
   end
end
