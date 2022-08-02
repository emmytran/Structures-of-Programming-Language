% _____________________Part 1_______________________

% deal([2,3,4], ([2,4],[3])) // mode:(+,+) // true
% deal([2,3,4],A) // mode:(+,-) // A = ([2, 4],3,[])
deal([],([],[])).
deal([X|Xs],([X|Ys], Z)):- deal(Xs,(Z,Ys)).

% merge([1,3],[2,4],Zs) // mode:(+,+,-) // Zs = [1, 2, 3, 4]
% merge([3,4,5],[6,7,8],[3,4,5,6,7,8]) // mode:(+,+,+) // true
merge([],Y,Y).
merge(X,[],X).
merge([X|Xs],[Y|Z],[A|B]) :-
    X=<Y -> A=X,
    merge(Xs,[Y|Z],B).
merge([X|Xs],[Y|Z],[A|B]) :-
    X>Y -> A=Y,
    merge([X|Xs],Z,B).

% ms([6,5,2,3,4],[2,3,4,5,6]) // mode:(+,+) // true
% ms([6,5,2,3,4],B) // mode:(+,-) // B = [2, 3, 4, 5, 6]
ms([],[]).
ms([X],[X]).
ms(Xs,Ys) :-
    deal(Xs,(A,B)),
    ms(A,C),
    ms(B,D),
    merge(C,D,Ys).

% cons(Out,X,snoc(snoc(snoc(nil, 5), 3), 4)) // mode:(+,+) // Out = 5, X = snoc(snoc(nil,3),4)
% cons(3,X,snoc(snoc(snoc(nil, 3), 1), 2)) // mode:(+,-,+) // X = snoc(snoc(nil,1),2)
cons(E, nil, snoc(nil,E)).
cons(E, snoc(BL,N), snoc(EBL,N)) :- cons(E, BL, EBL).

% toBList([1,5,8], Z) // mode:(+,-) // Z = snoc(snoc(snoc(nil,1),5),8)
toBList([],nil).
toBList([X|Xs],Z) :- toBList(Xs,BL), cons(X,BL,Z).

% snoc([1,2,3,4],5,[1,2,3,4,5]) // mode:(+,+,+) // true
% snoc([1,2,3],5,O) // mode: (+,+,-) // O = [1,2,3,5]
% snoc([1,2,3,4],Z,[1,2,3,4,5]) // mode:(+,-,+) // Z = 5
snoc(X,N,Y) :- append(X,[N],Y).

% fromBList(snoc(snoc(snoc(nil, 8), 9), 10),X) // mode:(+,-) // X = [8,9,10]
% fromBList(snoc(snoc(snoc(nil,8),9),10),[8,9,10]) // mode:(+,+) // true
fromBList(nil,[]).
fromBList(snoc(nil,E),E).
fromBList(snoc(BL,N),Res) :-
    fromBList(BL,List),
    snoc(List,N,Res).

% num_empties(node(5,node(3,empty,empty),empty),Out) // mode:(+,-) // Out = 3
% num_empties(node(1, empty, empty), B) // mode:(+,-) // B = 2
num_empties(empty, 1).
num_empties(node(_,L,R), N) :-
    num_empties(L,NL),
    num_empties(R,NR),
    N is NL + NR.

% num_nodes(node(1,node(2,empty,empty),node(3,empty,empty)),3) // mode: (+,+) // true
% num_nodes(node(1,node(2,empty,empty),node(3,empty,empty)),Z) // mode(+,-) // Z = 3
num_nodes(empty,0).
num_nodes(node(_,L,R),Res) :-
    num_nodes(L,R1),
    num_nodes(R,R2),
    Res is R1+R2+1.

% insert_left(1,empty,X) // mode: (+,-) // X = node(1,empty,empty)
% insert_left(1,node(3,empty,node(4,empty,empty)),Y) // mode: (+,-) // Y = node(3,node(1,empty,empty),node(4,empty,empty))
insert_left(E,empty,node(E,empty,empty)).
insert_left(E,node(A,L,R),node(A,AL,R)) :- insert_left(E,L,AL).

% insert_right(2,node(4,empty,node(5,empty,empty)),Z) // mode: (+,-) // Z = node(4,empty,node(5,empty,node(2,empty,empty)))
% insert_right(2,node(4,empty,node(5,empty,empty)),node(4, empty, node(5, empty, node(2, empty, empty)))) // mode:(+,+) // true
insert_right(E,empty,node(E,empty,empty)).
insert_right(E,node(A,L,R),node(A,L,AR)) :- insert_right(E,R,AR).

% sum_nodes(node(4,(node(3, empty, empty)),empty),A) // mode:(+,-) // X = 7
% sum_nodes(node(1,node(2,empty,empty),node(3,empty,empty)),6) // mode:(+,+) // true
sum_nodes(empty,0).
sum_nodes(node(A,L,R), N) :-
    sum_nodes(L,NL),
    sum_nodes(R, NR),
    N is NL + NR + A.

% inorder(node(4, empty, node(6, empty, empty)),A) // mode:(+,-) // A = [4,6]
% inorder(A, [4, 6]) // mode:(-,+) // A = node(4,empty,node(6,empty,empty))
% inorder(node(4,node(2,node(1,empty,empty),node(3,empty,empty)),node(6,empty,empty)),B) // mode:(-,+) // B = [1, 2, 3, 4, 6]
inorder(empty,[]).
inorder(node(E,empty,empty),[E]).
inorder(node(E,L,R),Res) :-
    inorder(L,List1),
    inorder(R,List2),
    append(List1,[E],FH),
    append(FH,List2,Res).

% num_elts(node2(9,leaf(2),leaf(4)),A) // mode (+,-) // A = 3
% num_elts(node2(1,node2(2,leaf(3),leaf(4)),leaf(5)),B) // mode:(+,-) // B = 5
num_elts(X,N) :- neh([X],0,N).
neh([],A,A).
neh([leaf(_)|Xs],A,N) :-
    AE is A+1,
    neh(Xs,AE,N).
neh([node2(_,L,R)|Xs],A,N) :-
    AE is A+1,
    neh([L,R|Xs],AE,N).

% sum_nodes2(node2(1,leaf(5),leaf(3)),A) // mode:(+,-) // A = 9
% sum_nodes2(node2(7,node2(3,leaf(1),leaf(2)),node2(3,leaf(1),leaf(2))),Out) // mode:(+,-) // Out = 19
sum_nodes2(leaf(E),E).
sum_nodes2(node2(A,L,R),S):-
    sum_nodes2(L,NL),
    sum_nodes2(R,NR),
    S is A + NL + NR.

% inorder2((node2(3,leaf(5),leaf(6))),Out) // mode:(+,-) // Out = [5, 3, 6]
% inorder2(Out,[5, 3, 6]) // mode:(-,+) // Out = node2(3,leaf(5),leaf(6))
% inorder2(node2(1,node2(2,leaf(3),leaf(4)),leaf(5)),Z) // mode:(+,-) // Z = [3, 2, 4, 1, 5]
inorder2(leaf(E),[E]).
inorder2(node2(E,L,R),Res) :-
    inorder2(L,List1),
    inorder2(R,List2),
    append(List1,[E],FH),
    append(FH,List2,Res).

% conv21(X, node(3, node(5, empty, empty), node(6, empty, empty))) // mode:(-,+) // X = node2(3,leaf(5),leaf(6))
% conv21(node2(3,leaf(5),leaf(6)),Y) // mode:(+,-) // Y = node(3,node(5,empty,empty),node(6,empty,empty))
conv21(leaf(E),node(E,empty,empty)).
conv21(node2(E,L,R),node(E,L2,R2)) :- conv21(L,L2),conv21(R,R2).

% _____________________Part 2_______________________

% toBList_it([1,2,3,4],X) // mode:(+,-) // X = snoc(snoc(snoc(snoc(nil,1),2),3),4)
toBList_it(L,Res) :- ltob(L,nil,Res).
ltob([],Y,Y).
ltob([X],Y,snoc(Y,X)).
ltob(L,Y,snoc(Y2,C)) :-
    last(L,C),
    append(InitL,[C],L),
    ltob(InitL,Y,Y2).

% fromBList_it(snoc(snoc(snoc(nil, 1), 2), 3),A) // mode: (+,-) // A = [1,2,3]
fromBList_it(Y,Res) :-
    btol(Y,[],Res).
    btol(nil,L,L).
    btol(snoc(Y,E),L,Res) :- btol(Y,L,L2),append(L2,[E],Res).

% sum_nodes_it(node(2,node(1,empty,empty),node(3,empty,empty)),Z) // mode:(+,-) // Z = 6
sum_nodes_it(X,N) :- sum_help([X], 0, N).
sum_help([], Y, Y).
sum_help([empty|Xs], Y, N) :- sum_help(Xs, Y, N).
sum_help([node(E,L,R)|Xs], Y, N) :-
    YE is Y + E,
    sum_help([L,R|Xs], YE, N).

% num_empties_it((node(2,empty,empty)),A) // mode:(+,-) // A = 2
num_empties_it(X,N) :- nempt_help([X],0,N).
nempt_help([],Y,Y).
nempt_help([empty|Xs],Y,N) :- YE is Y+1, nempt_help(Xs,YE,N).
nempt_help([node(_,L,R)|Xs],Y,N) :- nempt_help([L,R|Xs],Y,N).

% num_nodes_it((node(2,empty,empty)),A) // mode:(+,-) // A = 1
% num_nodes_it(node(2,node(1,empty,empty),node(3,empty,empty)),Out) // mode:(+,-) // A = 3
num_nodes_it(X,N) :- numn_help([X],0,N).
numn_help([],Y,Y).
numn_help([empty|Xs],Y,N) :- numn_help(Xs,Y,N).
numn_help([node(_,L,R)|Xs],Y,N) :-
    YE is Y+1,
    numn_help([L,R|Xs],YE,N).

% sum_nodes2_it(node2(7,node2(3,leaf(1),leaf(2)),node2(3,leaf(1),leaf(2))),Out) // mode:(+,-) // Out = 19
sum_nodes2_it(X,N) :- sum_help2([X],0,N).
sum_help2([],Y,Y).
sum_help2([leaf(E)|Xs],Y,N) :-
    YE is Y+E,
    sum_help2(Xs,YE,N).
sum_help2([node2(E,L,R)|Xs],Y,N) :-
    YE is Y+E,
    sum_help2([L,R|Xs],YE,N).

% inorder2_it(node2(1,node2(2,leaf(4),leaf(5)),leaf(3)),Z) // mode:(+,-) // Z = [4, 2, 5, 1, 3]
inorder2_it(X,Res) :- inord([X],[],Res).
inord([],L,L).
inord([leaf(E)|Xs],L,Res) :-
    append([E],L,Ls),
    inord(Xs,Ls,Res).
inord([node2(E,L,R)|Xs],L0,Res) :-
    append([R],[leaf(E)],L1),
    append(L1,[L],L2),
    append(L2,Xs,Ls),inord(Ls,L0,Res).

% _____________________Extra Credit_______________________

% conv12(node(1,node(2,empty,empty),node(3,empty,empty)),A) / mode:(+,-) / A = node2(1,_1698,_1700)
conv12(empty, nothing) :- !.
conv12(node(N,empty,empty,empty),node2(N)) :- !.
conv12(noode(_,_,empty),nothing) :- !.
conv12(node(_,empty,_),nothing) :- !.
conv12(node(N,L,R),node2(N,L2,R2)) :-
    L \= empty;
    R \= empty;
    conv12(L, L2),
    conv12(R,R2),!.

% less than function
% isAltB(fin(1),fin(2)) / mode:(+,+) / true
isAltB(neginf,fin(_)).
isAltB(fin(N),fin(M)) :- N<M.
isAltB(fin(_),posinf).

% helper function for bst
bst_helper(_,_,empty).
bst_helper(Lo,Hi,node(N,L,R)) :-
    isAltB(Lo,fin(N)),
    isAltB(fin(N),Hi),
    bst_helper(Lo,fin(N),L),
    bst_helper(fin(N),Hi,R).

% bst(node(5,node(3,node(2,empty,empty),node(4,empty,empty)),node(6,empty,empty)),A) / mode: (+,-) / A = true
bst(node(N,L,R),true) :- bst_helper(neginf,posinf,node(N,L,R)),!.
bst(_,false).

% bst2_helper(neginf,posinf,node2(15,node2(10,leaf(5),leaf(12)),node2(20,leaf(18),leaf(25)))) / mode:(+,+,+) / true
bst2_helper(Lo,Hi,leaf(N)) :- isAltB(Lo,fin(N)),
 isAltB(fin(N),Hi).
bst2_helper(Lo,Hi,node2(N,L,R)) :-
    isAltB(Lo,fin(N)),
     isAltB(fin(N),Hi),
    bst2_helper(Lo,fin(N),L),
     bst2_helper(fin(N),Hi,R).

% bst2(node2(15,node2(10,leaf(5),leaf(12)),node2(20,leaf(18),leaf(25))),A) / mode:(+,-) / A = true
bst2(node2(N,L,R),true) :-
    bst2_helper(neginf,posinf,node2(N,L,R)),!.
bst2(_,false).

















