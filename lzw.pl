filein('text.txt').
fileout('enc.txt').

memberx(N,[N|_]).
memberx(N,[_|T]):-memberx(N,T).
make_unique([],[]).
make_unique([H|T],Y):-memberx(H,T),!,make_unique(T,Y).
make_unique([H|T],[H|Y]):-make_unique(T,Y).

%maxinlist(S,Is,L,W,T,Y,I) S searched Word, 
%							Is Last Index,
%							L Text, 
%							W Wordbook, 
%							T New Text,
%							Y New Wordbook, 
%							I Index.
maxinlist(_,I,[],W,[],W,I).
maxinlist(S,I,[L|Ls],W,[L|Ls],Y,I) :- atom_concat(S,L,Sn), not(member(Sn,W)), append(W,[Sn],Y).
maxinlist(S,_,[L|Lr],W,T,Y,I) :- atom_concat(S,L,Sn), nth0(Is,W,Sn), maxinlist(Sn,Is,Lr,W,T,Y,I).

%lzw(T,W,I) T Word, W Wordbook, I Generated Word
lzw([],_,[]).
lzw(T,W,[I|Is]) :- maxinlist('',_,T,W,Xn,Wn,I), lzw(Xn,Wn,Is).

%wzl(I,W,T) I Generated Word, W Wordbook, T Word
wzl([I],W,[T]) :- nth0(I,W,T).
wzl([Il|[I|Is]],W,[Tl|Ts]) :- nth0(I,W,T), nth0(Il,W,Tl), atom_concat(Tl,T,Wn), append(W,[Wn],Ws), wzl([I|Is],Ws,Ts).

encode :- filein(Fin), fileout(Fout),
        open(Fin,read,Str),
        read(Str,Payload),
        close(Str),
        atom_chars(Payload,T),
        make_unique(T,W),
        lzw(T,W,I),
        open(Fout,write,Stream),
        write(Stream,W),  
        write(Stream,'.'), 
        nl(Stream),
        write(Stream,I),  
        write(Stream,'.'), 
        nl(Stream),
        close(Stream).

decode :- fileout(Fin), filein(Fout),
        open(Fin,read,Str),
        read(Str,W),
        read(Str,I),
        close(Str),
        wzl(I,W,T),
        atomic_list_concat(T,'',Ts),
        atomic_list_concat(W,'',Ws),
        open(Fout,write,Stream),
        write(Stream,Ws),  
        write(Stream,'.'), 
        nl(Stream),
        write(Stream,Ts),  
        write(Stream,'.'), 
        nl(Stream),
        close(Stream).