% Class to create a graph object
% dim: [x y]% Dimensions of the graph
% qi: initial vertex
% q: vertex [x y]
% e: edge [x1 y1 x2 y2]
classdef AreaGraph
	properties
		Graph
		Initial
		Adjacency
		Adjn
		Nodes
		Coords
	end
	
	methods
	% Constructor Method % Constructs object
      function obj = AreaGraph(G)
      	 if nargin > 0
            obj.Graph = G;
            obj.Initial = [];
	    	obj.Adjn = prod(size(G))% Size of adjacency matrix
            obj.Adjacency = zeros(obj.Adjn);
			x = 1:size(G,1);
			y = 1:size(G,2);
			[Y,X] = meshgrid(y,x);
			obj.Coords = [X(:) Y(:)];
			obj.Nodes = [];
         end
      end
      function obj = init(obj,val)
      	 if nargin > 0
            obj.Graph(val(1),val(2)) = 1;
            obj.Initial = val;
			obj.Nodes = val;
        end
      end
      function obj = addEdges(obj,val)
      	 if nargin > 0
            [~,val1] = pdist2(obj.Coords,[val(1) val(2)],'euclidean','Smallest',1);
            [~,val2] = pdist2(obj.Coords,[val(3) val(4)],'euclidean','Smallest',1);
% 			val1 = p2dist([val(1) val(2)],obj.Coords))
% 			val2 = find(ismember([val(3) val(4)],obj.Coords))
            obj.Adjacency(val1,val2) = 1;
            obj.Adjacency(val2,val1) = 1;
         end
      end
      function obj = addVertex(obj,val)
      	 if nargin > 0
	    obj.Graph(val(1),val(2)) = 1;
		obj.Nodes = [obj.Nodes;val];
         end
      end

   end
end
