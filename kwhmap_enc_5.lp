% Generate
% We want to get an output category for each input combination.
% F: wall
% W: window
% R: roof
% MH: (main)heating
% A: floor area
% O: output category

% We are looking for lower and upper bounds for each qualitative input binding on the HU side.
{ catHU(F,W,R,MH,A,LOW,HIGH) :  out_dim(LOW), 
			   			   out_dim(HIGH), 
			   			   LOW <= HIGH } = 1 :- in_dim_count(M), F = 1..M, W = 1..M, R = 1..M, MH = 1..M, A = 1..M.

% % The same qualitative input binding exists for the UK side.
% { catUK(F,W,R,LOW,HIGH) :  out_dim(LOW),
%                            out_dim(HIGH), 
%                            LOW <= HIGH } = 1 :- in_dim_count(M), F = 1..M, W = 1..M, R = 1..M.

% This is needed to make arithmetic operations safe.
{ in_dim(X) } = 1 :- in_dim_count(A), X=1..A.

% Define (what we know as generative rules)

% Helper functions to bind arithmetic variables to atoms.
in_dim(A,B) :- in_dim(A), in_dim(B).
in_dim(A,B,C,D) :- in_dim(A,B), in_dim(C,D).
in_dim(A,B,C,D,E,F) :- in_dim(A,B,C,D), in_dim(E,F).
in_dim(A,B,C,D,E,F,G,H) :- in_dim(A,B,C,D,E,F), in_dim(G,H).
in_dim(A,B,C,D,E,F,G,H,I,J) :- in_dim(A,B,C,D,E,F,G,H), in_dim(I,J).

lt(A,B) :- A < B, in_dim(A,B).
eq(A,B) :- A = B, in_dim(A,B).
gt(A,B) :- A > B, in_dim(A,B).

% One, two and three variable partial order relations.

% one variable
equalcat(X1,X2) :- X1 = X2, in_dim(X1,X2).
lowercat(X1,X2) :- X1 < X2, in_dim(X1,X2).


% two variables
equalcat(X1,Y1,X2,Y2) :- X1 = X2, Y1 = Y2, in_dim(X1,X2,Y1,Y2).

lowercat(X1,Y1,X2,Y2) :- X1 < X2, equalcat(Y1,Y2), in_dim(X1,X2,Y1,Y2).
lowercat(X1,Y1,X2,Y2) :- X1 < X2, lowercat(Y1,Y2), in_dim(X1,X2,Y1,Y2).

lowercat(X1,Y1,X2,Y2) :- Y1 < Y2, equalcat(X1,X2), in_dim(X1,X2,Y1,Y2).
lowercat(X1,Y1,X2,Y2) :- Y1 < Y2, lowercat(X1,X2), in_dim(X1,X2,Y1,Y2).


% three variables
equalcat(X1,Y1,Z1,X2,Y2,Z2) :- X1 = X2, Y1 = Y2, Z1 = Z2, in_dim(X1,X2,Y1,Y2,Z1,Z2).

lowercat(X1,Y1,Z1,X2,Y2,Z2) :- X1 < X2, equalcat(Y1,Z1,Y2,Z2), in_dim(X1,X2,Y1,Y2,Z1,Z2).
lowercat(X1,Y1,Z1,X2,Y2,Z2) :- X1 < X2, lowercat(Y1,Z1,Y2,Z2), in_dim(X1,X2,Y1,Y2,Z1,Z2).

lowercat(X1,Y1,Z1,X2,Y2,Z2) :- Y1 < Y2, equalcat(X1,Z1,X2,Z2), in_dim(X1,X2,Y1,Y2,Z1,Z2).
lowercat(X1,Y1,Z1,X2,Y2,Z2) :- Y1 < Y2, lowercat(X1,Z1,X2,Z2), in_dim(X1,X2,Y1,Y2,Z1,Z2).

lowercat(X1,Y1,Z1,X2,Y2,Z2) :- Z1 < Z2, equalcat(X1,Y1,X2,Y2), in_dim(X1,X2,Y1,Y2,Z1,Z2).
lowercat(X1,Y1,Z1,X2,Y2,Z2) :- Z1 < Z2, lowercat(X1,Y1,X2,Y2), in_dim(X1,X2,Y1,Y2,Z1,Z2).

% four variables
equalcat(X1,Y1,Z1,W1,X2,Y2,Z2,W2) :- X1 = X2, Y1 = Y2, Z1 = Z2, W1 = W2, in_dim(X1,X2,Y1,Y2,Z1,Z2,W1,W2).

lowercat(X1,Y1,Z1,W1,X2,Y2,Z2,W2) :- X1 < X2, equalcat(Y1,Z1,W1,Y2,Z2,W2), in_dim(X1,Y1,Z1,W1,X2,Y2,Z2,W2).
lowercat(X1,Y1,Z1,W1,X2,Y2,Z2,W2) :- X1 < X2, lowercat(Y1,Z1,W1,Y2,Z2,W2), in_dim(X1,Y1,Z1,W1,X2,Y2,Z2,W2).

lowercat(X1,Y1,Z1,W1,X2,Y2,Z2,W2) :- Y1 < Y2, equalcat(X1,Z1,W1,X2,Z2,W2), in_dim(X1,Y1,Z1,W1,X2,Y2,Z2,W2).
lowercat(X1,Y1,Z1,W1,X2,Y2,Z2,W2) :- Y1 < Y2, lowercat(X1,Z1,W1,X2,Z2,W2), in_dim(X1,Y1,Z1,W1,X2,Y2,Z2,W2).

lowercat(X1,Y1,Z1,W1,X2,Y2,Z2,W2) :- Z1 < Z2, equalcat(X1,Y1,W1,X2,Y2,W2), in_dim(X1,Y1,Z1,W1,X2,Y2,Z2,W2).
lowercat(X1,Y1,Z1,W1,X2,Y2,Z2,W2) :- Z1 < Z2, lowercat(X1,Y1,W1,X2,Y2,W2), in_dim(X1,Y1,Z1,W1,X2,Y2,Z2,W2).

lowercat(X1,Y1,Z1,W1,X2,Y2,Z2,W2) :- W1 < W2, equalcat(X1,Y1,Z1,X2,Y2,Z2), in_dim(X1,Y1,Z1,W1,X2,Y2,Z2,W2).
lowercat(X1,Y1,Z1,W1,X2,Y2,Z2,W2) :- W1 < W2, lowercat(X1,Y1,Z1,X2,Y2,Z2), in_dim(X1,Y1,Z1,W1,X2,Y2,Z2,W2).

% five variables
lowercat(X1,Y1,Z1,W1,A1,X2,Y2,Z2,W2,A2) :- X1 < X2, equalcat(Y1,Z1,W1,A1,Y2,Z2,W2,A2), in_dim(X1,Y1,Z1,W1,A1,X2,Y2,Z2,W2,A2).
lowercat(X1,Y1,Z1,W1,A1,X2,Y2,Z2,W2,A2) :- X1 < X2, lowercat(Y1,Z1,W1,A1,Y2,Z2,W2,A2), in_dim(X1,Y1,Z1,W1,A1,X2,Y2,Z2,W2,A2).

lowercat(X1,Y1,Z1,W1,A1,X2,Y2,Z2,W2,A2) :- Y1 < Y2, equalcat(X1,Z1,W1,A1,X2,Z2,W2,A2), in_dim(X1,Y1,Z1,W1,A1,X2,Y2,Z2,W2,A2).
lowercat(X1,Y1,Z1,W1,A1,X2,Y2,Z2,W2,A2) :- Y1 < Y2, lowercat(X1,Z1,W1,A1,X2,Z2,W2,A2), in_dim(X1,Y1,Z1,W1,A1,X2,Y2,Z2,W2,A2).

lowercat(X1,Y1,Z1,W1,A1,X2,Y2,Z2,W2,A2) :- Z1 < Z2, equalcat(X1,Y1,W1,A1,X2,Y2,W2,A2), in_dim(X1,Y1,Z1,W1,A1,X2,Y2,Z2,W2,A2).
lowercat(X1,Y1,Z1,W1,A1,X2,Y2,Z2,W2,A2) :- Z1 < Z2, lowercat(X1,Y1,W1,A1,X2,Y2,W2,A2), in_dim(X1,Y1,Z1,W1,A1,X2,Y2,Z2,W2,A2).

lowercat(X1,Y1,Z1,W1,A1,X2,Y2,Z2,W2,A2) :- W1 < W2, equalcat(X1,Y1,Z1,A1,X2,Y2,Z2,A2), in_dim(X1,Y1,Z1,W1,A1,X2,Y2,Z2,W2,A2).
lowercat(X1,Y1,Z1,W1,A1,X2,Y2,Z2,W2,A2) :- W1 < W2, lowercat(X1,Y1,Z1,A1,X2,Y2,Z2,A2), in_dim(X1,Y1,Z1,W1,A1,X2,Y2,Z2,W2,A2).

lowercat(X1,Y1,Z1,W1,A1,X2,Y2,Z2,W2,A2) :- A1 < A2, equalcat(X1,Y1,Z1,W1,X2,Y2,Z2,W2), in_dim(X1,Y1,Z1,W1,A1,X2,Y2,Z2,W2,A2).
lowercat(X1,Y1,Z1,W1,A1,X2,Y2,Z2,W2,A2) :- A1 < A2, lowercat(X1,Y1,Z1,W1,X2,Y2,Z2,W2), in_dim(X1,Y1,Z1,W1,A1,X2,Y2,Z2,W2,A2).

% Better buildings consume at most as much as the strictly worse buildings
H2 <= H1 :- catHU(F1,W1,R1,MH1,A1,L1,H1), catHU(F2,W2,R2,MH2,A2,L2,H2), lowercat(F1,W1,R1,MH1,A1,F2,W2,R2,MH2,A2).
% H2 <= H1 :- catUK(F1,W1,R1,L1,H1), catUK(F2,W2,R2,L2,H2), lowercat(F1,W1,R1,F2,W2,R2).

% Strictly worse buildings consume at least as much as the better buildings.
L1 >= L2 :- catHU(F1,W1,R1,MH1,A1,L1,H1), catHU(F2,W2,R2,MH2,A2,L2,H2), lowercat(F1,W1,R1,MH1,A1,F2,W2,R2,MH2,A2).
% L1 >= L2 :- catUK(F1,W1,R1,L1,H1), catUK(F2,W2,R2,L2,H2), lowercat(F1,W1,R1,F2,W2,R2).

% Test (what should hold / should not hold)

% Direct HU observations have to be adhered to.

% category_include(F,W,R,MH,O) :- category_include_HU(F,W,R,MH,O).
category_include(F,W,R,MH,A,O) :- category_include_HU(F,W,R,MH,A,O).
% category_include(F,W,R,MH,HU_O) :- category_include_HU(F,W,R,MH,HU_O), category_include_UK(F,W,R,MH,UK_O).

HIGH >= O :- category_include(F,W,R,MH,A,O), catHU(F,W,R,MH,A,LOW,HIGH).
LOW <= O  :- category_include(F,W,R,MH,A,O), catHU(F,W,R,MH,A,LOW,HIGH).

% HIGH >= O :- category_include(F,W,R,MH,O), catHU(F,W,R,MH,LOW,HIGH).
% LOW <= O  :- category_include(F,W,R,MH,O), catHU(F,W,R,MH,LOW,HIGH).

% % The same for UK observations.
% HIGH >= O :- category_include_UK(F,W,R,O), catUK(F,W,R,LOW,HIGH).
% LOW <= O  :- category_include_UK(F,W,R,O), catUK(F,W,R,LOW,HIGH).

% % We may want to set explicit lower and upper bounds for categories.
% % H <= HM :- cat_max_HU(F,W,R,HM), catHU(F,W,R,L,H).
% % L >= LM :- cat_min_HU(F,W,R,LM), catHU(F,W,R,L,H).

% % H <= HM :- cat_max_UK(F,W,R,HM), catUK(F,W,R,L,H).
% % L >= LM :- cat_min_UK(F,W,R,LM), catUK(F,W,R,L,H).


% % Transferring relative interval positions from the UK model to the Hungarian one.
% LHU1 < LHU2 :- lt(LUK1,LUK2),catUK(F1,W1,R1,LUK1,HUK1),catUK(F2,W2,R2,LUK2,HUK2),catHU(F1,W1,R1,LHU1,HHU1),catHU(F2,W2,R2,LHU2,HHU2).
% % LHU1 = LHU2 :- eq(LUK1,LUK2),catUK(F1,W1,R1,LUK1,HUK1),catUK(F2,W2,R2,LUK2,HUK2),catHU(F1,W1,R1,LHU1,HHU1),catHU(F2,W2,R2,LHU2,HHU2).
% LHU1 > LHU2 :- gt(LUK1,LUK2),catUK(F1,W1,R1,LUK1,HUK1),catUK(F2,W2,R2,LUK2,HUK2),catHU(F1,W1,R1,LHU1,HHU1),catHU(F2,W2,R2,LHU2,HHU2).

% HHU1 < HHU2 :- lt(HUK1,HUK2),catUK(F1,W1,R1,LUK1,HUK1),catUK(F2,W2,R2,LUK2,HUK2),catHU(F1,W1,R1,LHU1,HHU1),catHU(F2,W2,R2,LHU2,HHU2).
% % HHU1 = HHU2 :- eq(HUK1,HUK2),catUK(F1,W1,R1,LUK1,HUK1),catUK(F2,W2,R2,LUK2,HUK2),catHU(F1,W1,R1,LHU1,HHU1),catHU(F2,W2,R2,LHU2,HHU2).
% HHU1 > HHU2 :- gt(HUK1,HUK2),catUK(F1,W1,R1,LUK1,HUK1),catUK(F2,W2,R2,LUK2,HUK2),catHU(F1,W1,R1,LHU1,HHU1),catHU(F2,W2,R2,LHU2,HHU2).

% Inerval lengths - UK and HU
% ilength_UK(F,W,R,S) :- S = H - L, catUK(F,W,R,L,H).
ilength_HU(F,W,R,MH,A,S) :- S = H - L, catHU(F,W,R,MH,A,L,H).

% % sum of interval lengths and square sum of interval lengths for the UK
% ilength_sum_UK(L) :- L = #sum{ S: ilength_UK(F,W,R,S) }.
% ilength_sumsquare_UK(L) :- L = #sum{ S*S : ilength_UK(F,W,R,S) }.

ilength_sum_HU(L) :- L = #sum{ S,F,W,R,MH,A: ilength_HU(F,W,R,MH,A,S)}.
ilength_sumsquare_HU(L) :- L = #sum{ S*S, F,W,R,MH,A : ilength_HU(F,W,R,MH,A,S) }.

% % interval size difference square sum between HU and UK
% idiff_square(L) :- L = #sum{ S*S : S = LUK - LHU, ilength_UK(F,W,R,LUK), ilength_HU(F,W,R,LHU) }.

% % Let's find a UK intervalling which...
% %	- in addition to the qualitative ordering-induced interval positions
% %	- in addition to the "examples" provided for the UK
% %	- in addition to possibly explicitly set maxima/minima for certain qualitative categories
% % Also:
% %	- covers as many output categories as possible ("unless restricted otherwise, everything is possible")
% %	- is as "regular" as made possible by other constraints (evenly distributed interval lengths)

% % On the Hungarian side, we are looking for an intervalling which...
% %       - in addition to the qualitative ordering-induced interval positions
% %       - in addition to the "examples" provided for the UK
% %       - in addition to possibly explicitly set maxima/minima for certain qualitative categories
% %	- in addition to the relative positions of the interval bounds induced by the UK intervalling
% % Also:
% %	- has as similar interval lengths to the corresponding UK interval lengths as possible


% #minimize { Y@1: idiff_square(Y) }.
#minimize { Y@2: ilength_sumsquare_HU(Y) }.
#minimize { Y@1: ilength_sum_HU(Y) }.

%Display
#show catHU/7.
% #show catUK/5.
