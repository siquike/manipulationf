classdef MyClass
   properties
      Prop
   end
   methods
      function obj = MyClass(val)
         if nargin > 0
            obj.Prop = val;
         end
      end
   end
end
