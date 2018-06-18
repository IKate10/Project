( x — | check parity of number |
if the number is even returns “ok”, if it’s not returns “not ok” )
	: parity
	2 %
	if
	    ." ok " cr
	else
	    ." not ok "
	then ;

 ( x — | check prime of number)
: prime
   dup 2 <
     if
   ." it’ impossible to check " cr exit
    else
    then
     dup 2 =
      if ." number is prime " cr exit
      else
      then
        dup 2
	do
	  if
	dup r@ %
	else
	0
	then
	loop
	if
	." number is prime " cr
	else
	." number  is complex " cr
	then ;

( value — | allocates memory and stores value in memory )
	: alloc
	dup 0 =
	if
	    1 allot dup rot swap ! exit
	else
	then
	dup dup 8 / swap 8 %
	if
	    1+
	else
	then
	allot dup rot swap !
	;

( — addr | returns address )
	: alloc
	1 allot
	;

( x — )
	: prime_alloc
	dup 2 <
	if
	    drop 0 alloc exit
	else
	then
	dup 2 =
	if
	    drop 1 alloc exit
	else
	then
	dup 2
	do
	if
	    dup r@ %
	else
	    0
	then
	loop
	if
	    1 alloc
	else
	    0 alloc
	then
	;

( x y — x+1 y+1 | )
	: double_inc
	inc swap
         inc swap
	;

	( x y -- x y x y |
	copies  )
	: double_dup
	over swap
          dup rot swap
	;


	( from_address to_address — |
	copies one byte from from_address to to_address )
	: copy_char
	c@ swap c!
	;

( from_address to_address— |
	copies given amount of bytes from from_address to to_address )
	: copy_string
	0
	do
	double_dup
	copy_char
	double_inc
	loop
	drop drop
	;

( first_string_address second_string_address— result_address |
	concats two strings + returns new address )
	: concat
	swap dup count >r swap dup count >r dup count rot dup
	count rot + rot swap inc heap-alloc dup >r over dup count
	copy_string count r@ + swap dup count copy_string r> r> r> 1+ +
	swap dup rot + 0x 0 swap c!
	;

( x — x+1 | increments given value )
	: inc
	1 +
	;

( value — [сollatz_conjecture] |
	makes collatz conjecture  in stack )
	 : collatz
	repeat
	dup dup 2 %
	if
	    3 * inc
	else
	    2 /
	then
	dup
	1 =
	until
	;

	( value — | creates collatz conjecture and prints it )
	: collatz
	repeat
	dup 2 %
	if
	    3 * inc dup . cr
	else
	    2 / dup . cr
	then
	dup
	1 =
	until
	;

(value — r
: radical
        dup 1 <
           if drop ." Houston, we got a problem, the number must be positive"
       else
          2 1 -rot
          repeat
	dup prime
        if dup >r >r
          dup r> % r> swap not if
	repeat
	dup >r >r dup r> % r> swap
           if >r swap r> dup >r * swap r> 1 else dup >r / r> 0 then until
	then then swap 1 - dup if 1 + swap 1 + 0 else drop drop 1 then until then ;
