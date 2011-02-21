--%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%{{{1
--
--  File Name:              bigrat.lua
--  Package Name:           BigRat 
--
--  Project:    Big Rationals library for Lua
--  Mantainers: fmp - Frederico Macedo Pessoa
--              msm - Marco Serpa Molinaro
--
--  History:
--     Version      Autor       Date            Notes
--      alfa     fmp/msm    03/22/2003   Start of Development
--      beta     fmp/msm    07/11/2003   Release
--
--  Description:
--    Big rationals manipulation library for Lua.
--    Uses BigNum Library.
--    A Big Rational is a table with a field numerator and a field denominator
--       consisting of BigNums whose role is well described by their names. 
--       It also has a field signal which assumes the values '+' and '-'.
--
--$.%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


--%%%%%%%%        Start of Code        %%%%%%%%--

require( "BigNum.lua" ) ;

BigRat = {} ;
BigRat.mt = {} ;

--BigRat.new{{{1
--%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
--
--  Function: New 
--
--
--  Description:
--     Creates a new Big Rational based with numerator num1 
--       and denominator num2.
--
--  Parameters:
--     num1 - numerator: a string, number or BigNumber.
--     num2 - denominator: a string, number or BigNumber.
--
--  Returns:
--     A Big Rational, or a nil value if an error occured.
--
--  %%%%%%%% --
function BigRat.new( num1 , num2 ) --{{{2
   local bigrat = {} ;
   local f ;
   setmetatable(bigrat, BigRat.mt) ;
   if type( num1 ) == "table" then 
      --Check if is a BigRat
      if num1.num ~= nil and num1.den ~= nil then 
         bigrat.num = BigNum.new( num1.num ) ;
         bigrat.den = BigNum.new( num1.den ) ;
      else
         bigrat.num = BigNum.new( num1 ) ;
         bigrat.den = BigNum.new( "1" ) ;
      end
   elseif num1 ~= nil then
      if num2 == nil then
         bigrat.den = BigNum.new( "1" ) ;
      else
         bigrat.den = BigNum.new( num2 ) ;         
      end
      bigrat.num = BigNum.new( num1 ) ;
   else
      bigrat.den = BigNum.new( ) ;
      bigrat.num = BigNum.new( ) ;   
   end

   --Update the signals
   if bigrat.den.signal == "-" then
      if bigrat.num.signal == "-" then
         bigrat.num.signal = "+" ;
      else
         bigrat.num.signal = "-" ;
      end
      bigrat.den.signal = "+" ;
   end
   
   return bigrat ;
end

--%%%%%%%%%%%%%%%%%%%% Functions for metatable %%%%%%%%%%%%%%%%%%%%--{{{1
--BigRat.mt.sub{{{2
function BigRat.mt.sub( num1 , num2 )
   local temp = BigRat.new() ;
   local brat1 = BigRat.new( num1 ) ;
   local brat2 = BigRat.new( num2 ) ;
   BigRat.sub( brat1 , brat2 , temp ) ;
   return temp ;
end

--BigRat.mt.add{{{2
function BigRat.mt.add( num1 , num2 )
   local temp = BigRat.new() ;
   local brat1 = BigRat.new( num1 ) ;
   local brat2 = BigRat.new( num2 ) ;
   BigRat.add( brat1 , brat2 , temp ) ;
   return temp ;
end

--BigRat.mt.mul{{{2
function BigRat.mt.mul( num1 , num2 )
   local temp = BigRat.new() ;
   local brat1 = BigRat.new( num1 ) ;
   local brat2 = BigRat.new( num2 ) ;
   BigRat.mul( brat1 , brat2 , temp ) ;
   return temp ;
end

--BigRat.mt.div{{{2
function BigRat.mt.div( num1 , num2 )
   local brat1 = BigRat.new( num1 ) ;
   local brat2 = BigRat.new( num2 ) ;
   local brat3 = BigRat.new() ;
   local brat4 = BigRat.new() ;
   BigRat.div( brat1 , brat2 , brat3 , brat4 ) ;
   return brat3 , brat4 ;
end

--BigRat.mt.tostring{{{2
function BigRat.mt.tostring( brat )
   BigRat.simplify( brat ) ;
   return BigNum.mt.tostring( brat.num ) .. " / " .. BigNum.mt.tostring( brat.den ) ;
end

--BigRat.mt.pow{{{2
function BigRat.mt.pow ( num1 , num2 )
   local brat1 = BigRat.new( num1 ) ;
   local brat2 = BigRat.new( num2 ) ;
   return BigRat.pow( brat1 , brat2 )
end

--BigRat.mt.eq{{{2
function BigRat.mt.eq ( num1 , num2 )  
   return BigRat.eq( num1 , num2 )
end

--BigRat.mt.lt{{{2
function BigRat.mt.lt ( num1 , num2 )
   return BigRat.lt( num1 , num2 )
end

--BigRat.mt.le{{{2
function BigRat.mt.le ( num1 , num2 )
   return BigRat.le( num1 , num2 )
end

--BigRat.mt.unm{{{2
function BigRat.mt.unm ( num )
   local ret = BigRat.new( num )
   if ret.num.signal == '-' then
      ret.num.signal = '+'
   else
      ret.num.signal = '-'
   end
   return ret
end

--%%%%%%%%%%%%%%%%%%%% Metatable Definitions %%%%%%%%%%%%%%%%%%%%--{{{1

BigRat.mt.__metatable = "hidden"              ; -- answer to getmetatable(aBignum)
-- BigRat.mt.__index     = "inexistent field" ; -- attempt to acess nil valued field 
-- BigRat.mt.__newindex  = "not available"    ; -- attempt to create new field
BigRat.mt.__tostring  = BigRat.mt.tostring ;
-- arithmetics
BigRat.mt.__add = BigRat.mt.add ;
BigRat.mt.__sub = BigRat.mt.sub ;
BigRat.mt.__mul = BigRat.mt.mul ;
BigRat.mt.__div = BigRat.mt.div ;
BigRat.mt.__pow = BigRat.mt.pow ;
BigRat.mt.__unm = BigRat.mt.unm ;
-- Comparisons
BigRat.mt.__eq = BigRat.mt.eq   ; 
BigRat.mt.__le = BigRat.mt.le   ;
BigRat.mt.__lt = BigRat.mt.lt   ;
--concatenation
-- BigRat.me.__concat = ???

-- protect metatable BigRat.mt
setmetatable( BigRat.mt, { __index = "inexistent field", __newindex = "not available", __metatable="hidden" } ) ;

--%%%%%%%%%%%%%%%%%%%% Basic Functions %%%%%%%%%%%%%%%%%%%%--{{{1
--%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%{{{2
--
--  Function: ADD 
--
--  Description:
--     Adds two Big Rationals.
--
--  Parameters:
--     brat1, brat2 - Rationals to be added.
--     brat3 - result
--
--  Returns:
--     0
--
--  Exit assertions:
--     brat3 is the result of the sum.
--
--  %%%%%%%% --
--Funcao BigRat.add{{{2
function BigRat.add( brat1 , brat2 , brat3 )
   brat3.den = brat1.den * brat2.den ;
   brat3.num = ( brat1.num * brat2.den ) + ( brat2.num * brat1.den ) ;
   return brat3 ;
end

--%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%{{{2
--
--  Function: SUB 
--
--
--  Description:
--     Subtracts two Big Rationals.
--
--  Parameters:
--     brat1, brat2 - Rationals to be subtracted.
--     brat3 - result
--
--  Returns:
--     0
--
--  Exit assertions:
--     brat3 is the result of the subtraction.
--
--  %%%%%%%% --
--Funcao BigRat.sub{{{2
function BigRat.sub( brat1 , brat2 , brat3 )
   brat3.den = brat1.den * brat2.den ;
   brat3.num = ( brat1.num * brat2.den ) - ( brat2.num * brat1.den ) ;
   return brat3 ;
end

--%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%{{{2
--
--  Function: MUL 
--
--
--  Description:
--     Multiplies two Big Rationals.
--
--  Parameters:
--     brat1, brat2 - Rationals to be multiplied.
--     brat3 - result
--
--  Returns:
--     0
--
--  Exit assertions:
--     brat3 is the result of the multiplication.
--
--  %%%%%%%% --
--BigRat.mul{{{2
function BigRat.mul( brat1 , brat2 , brat3 )
   brat3.num = brat1.num * brat2.num ;
   brat3.den = brat1.den * brat2.den ;
   return 0 ;
end

--%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%{{{2
--
--  Function: DIV 
--
--
--  Description:
--     Divides brat1 by brat2.
--
--  Parameters:
--     brat1, brat2 - Rationals to be divided.
--     brat3 - result
--     brat4 - remainder
--
--  Returns:
--     0
--
--  Exit assertions:
--     brat3 is the result of the division.
--     brat4 is the remainder of the division.
--
--  %%%%%%%% --
--BigRat.div{{{2
function BigRat.div( brat1 , brat2 , brat3 )
   brat3.num = brat1.num * brat2.den ;
   brat3.den = brat1.den * brat2.num ;
   return brat3 ;
end

--%%%%%%%%%%%%%%%%%%%% Compound Functions %%%%%%%%%%%%%%%%%%%%--{{{1
--%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%{{{2
--
--  Function: POW / EXP  
--
--
--  Description:
--     Computes a big rational which represents the brat2-th power of brat1.
--
--  Parameters:
--     brat1 - base
--     brat2 - expoent
--
--  Returns:
--     Returns a big rational which represents the brat2-th power of bnum1.
--
--  %%%%%%%% --
--BigRat.pow{{{2
function BigRat.pow( bnum1 , bnum2 )
   if bnum1 == nil or bnum2 == nil then
      error( "Function BigRat.pow: parameter nil" ) ;
   end
   local x = BigRat.new( "8" ) ;
   local n = BigRat.new( bnum2.den ) ;
   local n2 ;
   local y = BigRat.new( ) ;
   local i ;
   local temp = BigRat.new( ) ;
   
   BigRat.simplify( bnum2 ) ;
   --Powering...
   temp.num = BigNum.exp( bnum1.num , bnum2.num ) ;
   temp.den = BigNum.exp( bnum1.den , bnum2.num ) ;
   
   --Root extraction...
   --First aprox.
   n2 = n - 1 ;
  
   for i = 0 , 4 do
      y.num = x.num ^ n2.num ;
      y.den = x.den ^ n2.num ;
      x = (( temp / y ) + ( n2 * x )) / n ;
   end
   return x ;
end

--%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%{{{2
--
--  Function: Simplify  
--
--
--  Description:
--     Divides numerator and denominator of a Big Rational by their G.C.D.
--
--  Parameters:
--     brat - Rational to be simplified.
--
--  Returns:
--     0 - OK.
--     1 - otherwise.
--
--  Exit Assertion:
--    brat is simplified.
--
--  %%%%%%%% --
--BigRat.simplify{{{2
function BigRat.simplify( brat )
   if brat == nil then
      error( "Function BigRat.simplify: parameter nil" ) ;
   end
   local gcd  = BigNum.new( ) ;
   local temp = BigRat.new( brat ) ;
   local devnull = BigNum.new( ) ;
   local zero = BigNum.new( "0" ) ;
   --Check if numerator is zero
   if BigNum.compareAbs( brat.num , zero ) == 0 then
      brat.den = BigNum.new( "1" ) ;
      return 0 ;
   end
   gcd = BigNum.gcd( brat.num , brat.den ) ;
   BigNum.div( temp.num , gcd , brat.num , devnull ) ;
   BigNum.div( temp.den , gcd , brat.den , devnull ) ;
   --Update the signal
   if brat.num.signal == '-' and brat.den.signal == '-' then
      brat.num.signal = '+' ;
      brat.den.signal = '+' ;
   end
   return 0 ;
end

--%%%%%%%%%%%%%%%%%%%% Comparison Functions %%%%%%%%%%%%%%%%%%%%--{{{1

--%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%{{{2
--
--  Function: EQ
--
--
--  Description:
--     Compares two Big Rationals.
--
--  Parameters:
--     brat1,brat2 - Rationals
--
--  Returns:
--     Returns true if they are equal or false otherwise.
--
--  %%%%%%%% --
--BigRat.eq{{{2
function BigRat.eq( brat1 , brat2 )
   if BigRat.compare( brat1 , brat2 ) == 0 then
      return true ;
   else
      return false ;
   end
end

--%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%{{{2
--
--  Function: LT
--
--
--  Description:
--     Verifies if bnum1 is lesser than bnum2.
--
--  Parameters:
--     brat1, brat2 - Rationals
--
--  Returns:
--     Returns true if brat1 is lesser than brat2 or false otherwise.
--
--  %%%%%%%% --
--BigRat.lt{{{2
function BigRat.lt( brat1 , brat2 )
   if BigRat.compare( brat1 , brat2 ) == 2 then
      return true ;
   else
      return false ;
   end
end

--%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%{{{2
--
--  Function: LE
--
--
--  Description:
--     Verifies if bnum1 is lesser or equal than bnum2.
--
--  Parameters:
--     brat1, brat2 - Rationals
--
--  Returns:
--     Returns true if brat1 is lesser or equal than brat2 or false otherwise.
--
--  %%%%%%%% --
--BigRat.le{{{2
function BigRat.le( brat1 , brat2 )
   local temp = -1 ;
   temp = BigRat.compare( brat1 , brat2 )
   if temp == 0 or temp == 2 then
      return true ;
   else
      return false ;
   end
end

--%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%{{{2
--
--  Function: Compare 
--
--
--  Description:
--     Compares values of bnum1 and bnum2.
--
--  Parameters:
--     brat1, brat2 - Rationals
--
--  Returns:
--     1 - |brat1| > |brat2|
--     2 - |brat1| < |brat2|
--     0 - |brat1| = |brat2|
--
--  %%%%%%%% --
--BigNum.compare{{{2
function BigRat.compare( bnum1 , bnum2 )
   local temp ;
   temp = bnum1 - bnum2 ;
   if temp.num[0] == 0 and temp.num.len == 1 then --Check if is zero
      return 0 ;
   elseif temp.num.signal == "-" then
      return 2 ;
   else
      return 1 ;
   end
end
