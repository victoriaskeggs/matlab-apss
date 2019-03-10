function [L, D] = ingestSurvivabilityData(filename, cutoff)
%INGESTSURVIVABILITYDATA Ingests the CSV generated be the python files in tetherSurvivability
%   This function takes a filename and a cutoff, and returns two vectors, lengths, and
%   diameters
rawCSV = csvread(filename);

[nRows, nCols] = size(rawCSV);

% Convert the matrix to a single col.
data = rawCSV(2:nRows, 2:nCols) > cutoff;
lastCol = zeros(1, nCols - 1);

for row = 1:(nRows-1)
    val = find(data(row, :), 1, 'last');
    
    if isempty(val)
        lastCol(row) = 1;
    else
        lastCol(row) = val(1);
    end
end

% Limit ourselves diameters that don't hit the end of the length param
firstRowTooLarge = find(lastCol >= nCols - 1, 1);

if ~isempty(firstRowTooLarge)
    lastCol = lastCol(1:firstRowTooLarge);
end

% Perform smoothing on the data
lastCol = smoothdata(lastCol, 'loess');
lastCol(lastCol < 1) = 1;

% Extract length and diameter
lengths = rawCSV(1, 2:nCols);
diameters = rawCSV(2:nRows, 1);

% Return results
L = interp1(lengths, lastCol);
D = diameters(1:size(L, 2));
L = L';

end

