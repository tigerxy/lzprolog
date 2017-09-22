# lzprolog
Implementations of Lempel–Ziv–Welch with Prolog. More informations about LZW you can find here: [https://en.wikipedia.org/wiki/Lempel–Ziv–Welch](https://en.wikipedia.org/wiki/Lempel–Ziv–Welch)
# Howto Encode
The ```text.txt``` must look like the example. Only one line of letters and no spaces.

Example:
```
hellothisisaexapmletext.
```

Type the command:
```
?- encode.
```
# Howto Decode
Type the command:
```
?- decode.
```
The ```enc.txt``` will look like this:
```
[o,h,i,s,a,p,m,l,e,x,t].
[1,8,7,7,0,10,1,2,3,18,4,8,9,4,5,6,7,8,10,22,10].
```
