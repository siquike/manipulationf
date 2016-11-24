% Class to create a graph object
% dim: [x y]% Dimensions of the graph
% qi: initial vertex
% q: vertex [x y]
% e: edge [x1 y1 x2 y2]
classdef Cylinder
	properties
		Center
		Radius
	end
	
	methods
	% Constructor Method % Constructs object
      function obj = Cylinder(cyl)
      	 if nargin > 0
            obj.Center = [cyl(1) cyl(2)];
            obj.Radius = cyl(3);
         end
      end
      function inside = Dist(obj,Xp)
      	 if nargin > 0
            D = pdist2(obj.Center,Xp);
            if sum(D < obj.Radius) > 0
                inside = 1;
            else
                inside = 0;
            end
        end
      end
   end
end
