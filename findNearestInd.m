function index = findNearestInd(vect,value)

%FUNCTION index = findNearestInd(vect,value)
% Search vector for value.  Returns index such that vect(index)= value 
%(closest approximation)

[min_diff, index] = min(abs(vect - value));