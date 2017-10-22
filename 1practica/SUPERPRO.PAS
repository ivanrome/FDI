PROGRAM VERIFICARyGENERAR_TARJETAS;
{programa con el que puedes o bien comprobar
o bien generar un n£mero de tarjeta}

FUNCTION DeCaracterAEntero (caracter:char):integer;
{pasa los n£meros en forma de car cter a d¡gitos tipo integer}
         begin
         DeCaracterAEntero:=ord(caracter)-ord('0');
         end;  {decaracteraentero}

FUNCTION CasoImpar (numero: integer): integer;
{coge un integer y lo modifica conforme con lo que
se necesita en los casos que ocupa posici¢n impar}
         begin
         numero:=numero*2;
         if numero >= 10 then CasoImpar:=numero-9
                       else CasoImpar:=numero;
         end ; {casoimpar}


PROCEDURE verificar;
{procedimiento para comprobar la validez de un n£mero de tarjeta}
          var suma,i:integer; c:char;
          Begin
          writeln ('Escriba los n£meros');
          suma:=0;     i:=1;
          while (i<=16) do
            Begin
             read(c);
             if i mod 2=0 then suma:=suma+DeCaracterAEntero(c)
                      else suma:=suma+CasoImpar(DeCaracterAEntero(c));
              i:=i+1
            End; {while (i<=16)}
           if suma mod 10 = 0 then writeln ('Tarjeta v lida')
                           else writeln ('Tarjeta no v lida');
           readln;
           End; {verificar}


PROCEDURE generar;
{procedimiento que permite generar un
n£mero de tarjeta v lido aleatoriamente}
          var i,n,suma:integer;
          begin
          randomize;
          i:=0;
          suma:=0;
          while i<15 do begin
                     i:=i+1; n:=random(10); write (n);
                     if i mod 2 =0 then suma:= suma+n
                                   else suma:= suma + CasoImpar (n);
                                   {llama a la funci¢n que se encarga de
                                   manipular los d¡gitos que ocupan
                                   posici¢n impar}  end; {while 1<15}
           if suma mod 10 =0 then writeln ('0')
                             else writeln (10-(suma mod 10)); verificar;
          end; {generar}


VAR n: integer; {declaraci¢n de las variables del programa principal}

Begin  {comienzo del programa principal}

writeln ('                     Menu');
writeln ('Para comprobar validez de un numero       => pulse 1');
writeln ('Para generar numero de tarjeta            => pulse 0');
readln(n)     ;
if n=1 then verificar;
if n=0 then generar;
if (n<>1) and (n<>0) then writeln ('Error. Vuelva a comenzar');
readln;
end. {VERIFICARyGENERAR_TARJETAS;}