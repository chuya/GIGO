function finalVectors = fuse(randomProjection, varargin)

finalVectors = [];
for vectorIndex = 1:numel(varargin)
    finalVectors = cat(2,finalVectors,varargin{vectorIndex});
end

if randomProjection    
    randomProjectionSpace = normrnd( 0, 1, size(finalVectors, 2)*0.75, size(finalVectors, 2));
    finalVectors = finalVectors * randomProjectionSpace';
end