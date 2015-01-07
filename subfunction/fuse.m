function finalVectors = fuse(varargin)

finalVectors = [];
for vectorIndex = 1:numel(varargin)
    finalVectors = cat(2,finalVectors,varargin{vectorIndex});
end

