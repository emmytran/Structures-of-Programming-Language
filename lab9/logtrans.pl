determiner(S,P1,P2,[every|X],X,all(S,imply(P1,P2))).
determiner(S,P1,P2,[a|X],X,exists(S,and(P1,P2))).

noun(N,[man|X],X,man(N)).
noun(N,[woman|X],X,woman(N)).
noun(N,[child|X],X,child(N)).

name([john|X],X,john()).
name([mary|X],X,mary()).
name([emmy|X],X,emmy()).
name([claire|X],X,claire()).

transVerb(S,O,[loves|X],X,loves(S,O)).
transVerb(S,O,[knows|X],X,knows(S,O)).

intransVerb(S,[lives|X],X,lives(S)).
intransVerb(S,[runs|X],X,runs(S)).

sentence(X0,X,P) :- 
    nounPhrase(N,P1,X0,X1,P),
    verbPhrase(N,X1,X,P1).

nounPhrase(N,P1,X0,X,P) :- 
    determiner(N,P2,P1,X0,X1,P),
    noun(N,X1,X2,P3),
    relClause(N,P3,X2,X,P2).
nounPhrase(N,P1,X0,X,P1) :- name(X0,X,N).
    
verbPhrase(S,X0,X,P) :- 
    transVerb(S,O,X0,X1,P1), 
    nounPhrase(O,P1,X1,X,P).
verbPhrase(S,X0,X,P) :- 
    intransVerb(S,X0,X,P).

relClause(S,P1,[who|X1],X,and(P1,P2)) :- 
    verbPhrase(S,X1,X,P2). 
relClause(S,P1,[who|X1],X,and(P1,P2)) :- 
    name(X1,X0,N),
    transVerb(N,S,X0,X,P2).
relClause(S,P1,X,X,P1). 

% ?- sentence([every,man,who,john,loves,loves,a,woman,who,runs],[],A).
% output: A = all(_1752,imply(and(man(_1752),loves(john(,_1752)),exists(_1782,and(and(woman(_556),runs(_556)),loves(_526,_556)))))
% output: A = all(X,imply(and(man(X),loves(john(X)),exists(Y,and(and(woman(Z),runs(Z)),loves(Z,Z)))))

% ?- sentence([every,woman,who,loves,mary,loves,a,man,who,runs],[],B).
% output: B = all(_1752,imply(and(woman(_1752),loves(_1752,mary()),exists(_1782,and(and(man(_556),runs(_556)),loves(_526,_556)))))
% output: B = all(X,imply(and(woman(X),loves(X,mary()),exists(Y,and(and(man(Z),runs(Z)),loves(T,Z))))

% ?- sentence([every,woman,who,knows,every,man,who,emmy,loves,runs],[],C).
% output: C = all(_1752,imply(and(woman(_1752),all(_1774,imply(and(man(_1774),loves(emmy(,_548)),knows(_526,_548)))),runs(_526)))
% output: C = all(X,imply(and(woman(X),all(Y,imply(and(man(Y),loves(emmy(Z)),knows(T,Z)))),runs(T)))

% ?- sentence([every,woman,who,knows,every,man,who,loves,claire,runs],[],D).
% output: D = all(_1748,imply(and(woman(_1748),all(_1770,imply(and(man(_1770),loves(_544,claire()),knows(_522,_544)))),runs(_522)))
% output: D = all(X,imply(and(woman(X),all(Y,imply(and(man(Y),loves(Z,claire()),knows(T,Z)))),runs(T)))

% ?- sentence([every,man,who,loves,a,child,knows,a,woman,who,lives],[],E).
% output: E = all(_1752,imply(and(man(_1752),exists(_1774,and(child(_1774),loves(_1752,_1774)))),exists(_570,and(and(woman(_570),lives(_570)),knows(_526,_570)))))
% output: E = all(X,imply(and(man(X),exists(Y,and(child(Y),loves(X,Y)))),exists(Z,and(and(woman(Z)Z,lives(Z)),knows(T,Z)))))