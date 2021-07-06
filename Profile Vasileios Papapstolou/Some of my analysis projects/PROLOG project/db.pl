/*
Vasileios Papapostolou 3176
Dimitrios Tsaligopoulos 2933
Euaggelos Charalampakis 2098
*/

length/2.
member/2.
delete/3.
append/3.
permutation/2.
succ/2.
sublist/2.
write/1.
sort/2

:- dynamic attends/2.

attends(476, im218).
attends(478, im218).
attends(479, im218).
attends(481, im218).
attends(482, im218).
attends(483, im218).
attends(484, im218).
attends(485, im218).
attends(487, im218).
attends(488, im218).
attends(489, im218).
attends(490, im218).
attends(491, im218).
attends(492, im218).
attends(494, im218).
attends(495, im218).
attends(496, im218).
attends(497, im218).
attends(498, im218).
attends(500, im218).
attends(501, im218).
attends(505, im218).
attends(506, im218).
attends(507, im218).
attends(508, im218).
attends(510, im218).
attends(512, im218).
attends(514, im218).
attends(517, im218).
attends(518, im218).
attends(479, im217).
attends(481, im217).
attends(486, im217).
attends(493, im217).
attends(494, im217).
attends(495, im217).
attends(497, im217).
attends(499, im217).
attends(502, im217).
attends(503, im217).
attends(504, im217).
attends(520, im217).
attends(507, im217).
attends(509, im217).
attends(512, im217).
attends(513, im217).
attends(514, im217).
attends(516, im217).
attends(476, im204).
attends(478, im204).
attends(482, im204).
attends(485, im204).
attends(486, im204).
attends(487, im204).
attends(488, im204).
attends(489, im204).
attends(490, im204).
attends(491, im204).
attends(492, im204).
attends(493, im204).
attends(494, im204).
attends(496, im204).
attends(498, im204).
attends(499, im204).
attends(500, im204).
attends(501, im204).
attends(502, im204).
attends(503, im204).
attends(505, im204).
attends(520, im204).
attends(508, im204).
attends(509, im204).
attends(510, im204).
attends(512, im204).
attends(513, im204).
attends(514, im204).
attends(515, im204).
attends(516, im204).
attends(517, im204).
attends(518, im204).
attends(479, im210).
attends(480, im210).
attends(481, im210).
attends(483, im210).
attends(484, im210).
attends(491, im210).
attends(497, im210).
attends(508, im210).
attends(513, im210).
attends(515, im210).
attends(517, im210).
attends(476, im209).
attends(478, im209).
attends(480, im209).
attends(481, im209).
attends(482, im209).
attends(484, im209).
attends(485, im209).
attends(487, im209).
attends(488, im209).
attends(489, im209).
attends(490, im209).
attends(492, im209).
attends(493, im209).
attends(495, im209).
attends(496, im209).
attends(497, im209).
attends(498, im209).
attends(499, im209).
attends(500, im209).
attends(504, im209).
attends(506, im209).
attends(515, im209).
attends(516, im209).
attends(518, im209).
attends(476, im216).
attends(478, im216).
attends(484, im216).
attends(487, im216).
attends(491, im216).
attends(492, im216).
attends(493, im216).
attends(496, im216).
attends(498, im216).
attends(501, im216).
attends(502, im216).
attends(504, im216).
attends(505, im216).
attends(507, im216).
attends(509, im216).
attends(512, im216).
attends(513, im216).
attends(514, im216).
attends(515, im216).
attends(479, im214).
attends(480, im214).
attends(482, im214).
attends(483, im214).
attends(485, im214).
attends(486, im214).
attends(488, im214).
attends(489, im214).
attends(490, im214).
attends(494, im214).
attends(495, im214).
attends(499, im214).
attends(500, im214).
attends(503, im214).
attends(504, im214).
attends(505, im214).
attends(506, im214).
attends(520, im214).
attends(507, im214).
attends(508, im214).
attends(510, im214).
attends(516, im214).
attends(517, im214).
attends(518, im214).
attends(480, im212).
attends(483, im212).
attends(486, im212).
attends(501, im212).
attends(502, im212).
attends(503, im212).
attends(506, im212).
attends(520, im212).
attends(509, im212).
attends(510, im212).


students(T) :-
	findall(X,attends(X,Y),T),
	sort(T,T1),
	write(T1).


sublist(S,L) :-
    append(L1,L2,L),
    append(S,L3,L2).

not_member(_,[]).
not_member(E,[H|T]) :-
    E \= H,
    not_member(E,T).


intersect([],_L2,[]).
intersect([H1|T1],L2,[H1|T]) :-
    member(H1,L2),
    intersect(T1,L2,T).
intersect([H1|T1],L2,L) :-
    not_member(H1,L2),
    intersect(T1,L2,L).

k_permutation(0,_,[]).
k_permutation(K,L1,[X|T2]) :-
    K > 0, K1 is K - 1,
    delete(X,L1,L2),
    k_permutation(K1,L2,T2).


schedule(A,B,C):-
    permutation([im204,im209,im210,im212,im214,im216,im217,im218],X),
    sublist(A,X),
    sublist(B,X),
    sublist(C,X),
    length(A,3),
    length(B,3),
    length(C,2),
    intersect(A,B,[]),
    intersect(B,C,[]),
    intersect(C,A,[]).



schedule_errors(A,B,C,E) :-
	findall(X,attends(X,Y),T),
	sort(T,T1),
	program(A,B,C,T1,E).


program(A,B,C,[],0).
program(A,B,C,[H|T],E) :- 
	((check_week(A,H);check_week(B,H)), 
	program(A,B,C,T,TEMP),
	E is TEMP+1);
	program(A,B,C,T,E),!.
	
	
check_week([K1|K],X) :-
	attends(X,K1),
	check_week(K,X).
	
check_week([],X).



minimal_schedule_errors(A,B,C,E) :-
	schedule(A,B,C), schedule_errors(A,B,C,E), E==0.


score_schedule(A,B,C,S) :- 
	findall(X,attends(X,Y),T),
	sort(T,T1),
	calculate_week(A,T1,S1),!,
	calculate_week(B,T1,S2),!,
	calculate_week3(C,T1,S3),!,
	S is S1+S2+S3.


calculate_week([A1|[A2|[A3|Tail]]],[],0).
calculate_week([A1|[A2|[A3|Tail]]],[T|T1],S) :-
	((attends(T,A1),attends(T,A2),attends(T,A3), calculate_week([A1|[A2|[A3|[]]]],T1,TEMP), S is TEMP-7);
	(attends(T,A1), plus_one([A2,A3], T), calculate_week([A1|[A2|[A3|[]]]],T1,TEMP), S is TEMP+1);
	(not(attends(T,A1)),attends(T,A2),attends(T,A3),calculate_week([A1|[A2|[A3|[]]]],T1,TEMP), S is TEMP+1);
	(attends(T,A1), plus_three([A2,A3], T), calculate_week([A1|[A2|[A3|[]]]],T1,TEMP), S is TEMP+3);
	(not(attends(T,A1)), (plus_one([A2,A3],T);plus_three([A2,A3],T)), calculate_week([A1|[A2|[A3|[]]]],T1,TEMP), S is TEMP+7);
	(attends(T,A1), not(attends(T,A2)), not(attends(T,A3)),calculate_week([A1|[A2|[A3|[]]]],T1,TEMP), S is TEMP+7));
	calculate_week([A1|[A2|[A3|[]]]],T1,S),!.
	
	
	
plus_three([K1,K],X) :-
	not(attends(X,K1)),
	attends(X,K).

plus_one([K1,K],X) :-
	attends(X,K1),
	not(attends(X,K)).

calculate_week3([A1|[A2|Tail]],[],0).
calculate_week3([A1|[A2|Tail]],[T|T1],S) :-
	((attends(T,A1),attends(T,A2),calculate_week3([A1|[A2|[]]],T1,TEMP), S is TEMP+1);
	(attends(T,A1), not(attends(T,A2)), calculate_week3([A1|[A2|[]]],T1,TEMP), S is TEMP+7);
	(not(attends(T,A1)), attends(T,A2), calculate_week3([A1|[A2|[]]],T1,TEMP), S is TEMP+7));
	calculate_week3([A1|[A2|[]]],T1,S),!.


	









