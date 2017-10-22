PROGRAM practica5;
USES graphics,crt;

CONST
  MAX = 100; {m ximo n£mero de puntos y de l¡neas en el dibujo }
  F   = 0.6; { factor de reducci¢n para la perspectiva del eje Z }
  ALFA = PI/6; {  ngulo del eje z con respecto a los ejes x e y }

TYPE

     { puntos en 3 dimensiones }
      Tpunto3D = RECORD
                 x,y,z:real;  { las coordenadas }
                 END;

      Tpuntos3D = RECORD
                  v: ARRAY [1..MAX] of TPunto3D; { aqui guardamos los puntos }
                  cuantos:integer { elementos ocupados en v }
                  END;

     { puntos en 2 dimensiones }
      Tpunto2D = RECORD
                 x,y:integer; {  las coordenadas }
                 END;

      Tpuntos2D = RECORD
                  v: ARRAY [1..MAX] of TPunto2D;
                  cuantos:integer {elementos ocupados en v }
                  END;

     { las rectas valen tanto para 3 como para 2 dimensiones }
      Trecta = RECORD
               inicio:1..MAX; { pos. del punto inicial en el vector de puntos }
               fin   :1..MAX; { pos. del punto final en el vector de puntos }
               END;
      Trectas = RECORD
               v: ARRAY [1..MAX] of TRecta;
               cuantos:integer
               END;

     { un grafico en 3d esta formado por puntos 3d y rectas que los unen }
      Tgrafico3d = RECORD
                   puntos: TPuntos3d;
                   rectas: TRectas;
                   END;

     { un grafico en 2d esta formado por puntos 2d y rectas que los unen }
      Tgrafico2d = RECORD
                   puntos: TPuntos2d;
                   rectas: TRectas;
                   END;


     { Fichero donde guardaremos la secuencia a reproducir }
      Tsecuencia= FILE OF TGrafico2D;


{----------------------------------------------------------------}

{ ----------   Representaci¢n de los gr ficos en pantalla -------}

 { cambia el gr fico de 3d a 2d }
PROCEDURE grafico3Da2D(graf3d:TGrafico3d; VAR graf2d: TGrafico2d);
VAR i:integer;
BEGIN
   graf2d.rectas:=graf3d.rectas;
   graf2d.puntos.cuantos:=graf3d.puntos.cuantos;
   For i:=1 to graf3d.puntos.cuantos do
      Begin
         graf2d.puntos.v[i].x:=160+round(graf3d.puntos.v[i].x-graf3d.puntos.v[i].z*F*cos(ALFA));
         graf2d.puntos.v[i].y:=100-round(graf3d.puntos.v[i].y-graf3d.puntos.v[i].z*F*sin(ALFA));
      End;
END;


{ pinta en la pantalla el gr fico 2d que se pasa en el color indicado }
PROCEDURE dibuja(const d:tgrafico2d; colorR:integer);
VAR i:integer;
BEGIN
  setcolor(colorR);
  For i:=1 to d.rectas.cuantos do
    line(d.puntos.v[d.rectas.v[i].inicio].x,d.puntos.v[d.rectas.v[i].inicio].y,
         d.puntos.v[d.rectas.v[i].fin].x,d.puntos.v[d.rectas.v[i].fin].y);
END;{procedure}

{ Realiza un paso de animaci¢n.
- page: es la p gina gr fica auxiliar.
- dantiguo: dibujo que est  presentado ahora mismo.
- dNuevo: dibujo que debemos mostrar.
- color: color en el que debemos dibujar 'dNuevo'.

Precondiciones: - dAntiguo est  dibujado en 'page' y en la pantalla
Postcondicones: - dnuevo est  dibujado en 'page' y en la pantalla
}
PROCEDURE animacion(var page:pagetype; const dAntiguo,dNuevo:TGrafico2d);
BEGIN
dibuja(dAntiguo,black);
dibuja(dNuevo,81{random(255)+1});
waitRetrace;
copyPageToVGA(page);
END;


{ -------- Construcci¢n del gr fico 3D inicial  -------}


{ genera el gr fico vac¡o, con 0 l¡neas y 0 puntos }
PROCEDURE graficoVacio(var d:Tgrafico3d);
BEGIN
d.puntos.cuantos:=0;
d.rectas.cuantos:=0
END;



{ a¤ade una recta al gr fico }
PROCEDURE nuevaRecta(r:TRecta; var d:Tgrafico3d);
BEGIN
  With d.rectas do
   Begin cuantos:=cuantos+1; v[cuantos]:=r end;
END;



{ a¤ade un punto al gr fico }
PROCEDURE nuevoPunto(p:Tpunto3d; var d:Tgrafico3d);
BEGIN
  With d.puntos do
   Begin cuantos:=cuantos+1; v[cuantos]:=p end;
END;

{ crea la imagen 3d inicial, utilizando los proc. anteriores }
PROCEDURE creaImagen3d(var d:Tgrafico3d);
VAR p:Tpunto3d; r:Trecta;
BEGIN
GraficoVacio(d);
p.x:=50;   p.y:=0;   p.z:=50;
nuevoPunto(p,d);
p.x:=50;   p.y:=0;   p.z:=-50;
nuevoPunto(p,d);
p.x:=-50;   p.y:=0;   p.z:=-50;
nuevoPunto(p,d);
p.x:=-50;   p.y:=0;   p.z:=50;
nuevoPunto(p,d);
p.x:=0;   p.y:=100;   p.z:=0;
nuevoPunto(p,d);

p.x:=0;   p.y:=-100;   p.z:=0;
nuevoPunto(p,d);

r.inicio:=1; r.fin:=2;
nuevarecta(r,d);
r.inicio:=1; r.fin:=4;
nuevarecta(r,d);
r.inicio:=2; r.fin:=3;
nuevarecta(r,d);
r.inicio:=3; r.fin:=4;
nuevarecta(r,d);
r.inicio:=5; r.fin:=1;
nuevarecta(r,d);
r.inicio:=5; r.fin:=2;
nuevarecta(r,d);
r.inicio:=5; r.fin:=3;
nuevarecta(r,d);
r.inicio:=5; r.fin:=4;
nuevarecta(r,d);

r.inicio:=6; r.fin:=1;
nuevarecta(r,d);
r.inicio:=6; r.fin:=2;
nuevarecta(r,d);
r.inicio:=6; r.fin:=3;
nuevarecta(r,d);
r.inicio:=6; r.fin:=4;
nuevarecta(r,d);

END;

{ -------- Transformaciones  -------}


{ traslaci¢n seg£n el vector representado por p }
PROCEDURE trasladaGrafico(var d:Tgrafico3d; p:Tpunto3d);
VAR i:integer;
BEGIN
FOR i:=1 to d.puntos.cuantos do
    Begin
    d.puntos.v[i].x:=d.puntos.v[i].x+p.x;
    d.puntos.v[i].y:=d.puntos.v[i].y+p.z;
    d.puntos.v[i].z:=d.puntos.v[i].z+p.y;
    End
END;


{ dilataci¢n seg£n la escala fijada por p }
PROCEDURE dilataGrafico(var d:Tgrafico3d; p:Tpunto3d);
VAR i:integer;
BEGIN
FOR i:=1 to d.puntos.cuantos do
    Begin
    d.puntos.v[i].x:=d.puntos.v[i].x*p.x;
    d.puntos.v[i].y:=d.puntos.v[i].y*p.z;
    d.puntos.v[i].z:=d.puntos.v[i].z*p.y;
    End
END;


{ giro seg£n el  ngulo indicado. Se har  como 3 giros consecutivos, uno
al rededor de cada eje }
PROCEDURE giraGrafico(var d:Tgrafico3d;angulo:TPunto3D);
var i:integer; puntosAux:Tpunto3D;
BEGIN

for i:=1 to d.puntos.cuantos do
with d.puntos do
Begin {GIRO X}
puntosAux:=v[i];
v[i].y := puntosAux.y*cos(angulo.x{*puntosAux.x}) - puntosAux.z*sin(angulo.x{*puntosAux.x});
v[i].z := puntosAux.y*sin(angulo.x{*puntosAux.x}) + puntosAux.z*cos(angulo.x{*puntosAux.x});
end;{for}

for i:=1 to d.puntos.cuantos do
with d.puntos do
Begin  {GIRO Y}
puntosAux:=v[i];
v[i].x := puntosAux.x*cos(angulo.y{*puntosAux.y}) - puntosAux.z*sin(angulo.y{*puntosAux.y});
v[i].z := puntosAux.x*sin(angulo.y{*puntosAux.y}) + puntosAux.z*cos(angulo.y{*puntosAux.y})
End;{for}

for i:=1 to d.puntos.cuantos do
with d.puntos do
Begin  {GIRO Z}
puntosAux:=v[i];
v[i].x := puntosAux.x*cos(angulo.z{*puntosAux.z}) - puntosAux.y*sin(angulo.z{*puntosAux.z});
v[i].y := puntosAux.x*sin(angulo.z{*puntosAux.z}) + puntosAux.y*cos(angulo.z{*puntosAux.z})
End;{for}{with}
END;{procedure}


{ realiza una acci¢n sobre el gr fico, apoy ndose en los 3 subprogramas anteriores.
y muestra el paso de animaci¢n correspondiente por pantalla
- page: la p gina gr fica auxiliar que se utiliza en el proc. "animacion".
- laAccion: Una de las tres posibles, tal y como indica el tipo TAccion
- graf3d: el gr fico al que queremos aplicar la transformaci¢n.
Quedar  modificado.
- graf2d: 'graf2d' pero pasado a 2 dimensiones.
- valor: Si la acci¢n es una traslaci¢n representa el vector de traslaci¢n,
si es una dilataci¢n la escala, y si es un  un giro repr. el  ngulo.
- veces: Las veces que hay que repetir la acci¢n.
- color: El color en el que se mostrar  el gr fico transformado.
Precond.: 'graf2d' es la repr. en 2 dimensiones de 'graf3d'.
Precond.: 'graf2d' contin£a siendo la repr. en 2 dimensiones de 'graf3d',
que ha sido transformado
}
PROCEDURE accion(VAR fich:Tsecuencia; VAR graf:TGrafico3D; accion:char;  valor:TPunto3D; veces:integer);
{fich abierto en modo lectura
 graf abierto en modo escritura}
VAR i:integer; graf2D:Tgrafico2D;
BEGIN
CASE accion of
              't': for i:=1 to veces do
                              Begin
                              trasladagrafico(graf, valor);
                              grafico3Da2D(graf,graf2D);
                              write(fich,graf2D);
                              End; {for traslada}
              'd': for i:=1 to veces do
                              Begin
                              dilatagrafico(graf, valor);
                              grafico3Da2D(graf,graf2D);
                              write(fich,graf2D);
                              End; {for dilata}
              'g': for i:=1 to veces do
                              Begin
                              giragrafico(graf,valor);
                              grafico3Da2D(graf,graf2D);
                              write(fich,graf2D);
                              End {for gira}
              End {case}
END;  {procedure accion}


PROCEDURE creaSecuencia(leer,escribir:String);
 var
  d:tgrafico3d;     acciones:text ;
  d2: tgrafico2d;   secuencia:Tsecuencia ;
  p:Tpunto3d;       act:char;               veces:integer;
 Begin
  assign(acciones, leer);
  assign(secuencia, escribir);
  reset(acciones);       {abre en modo lectura}
  rewrite(secuencia);    {abre en modo escritura}
  creaImagen3D(d);
  grafico3Da2D(d,d2);
  while not eof(acciones) do
    Begin
    readln(acciones,act,p.x,p.y,p.z, veces);
    accion(secuencia, d, act, p, veces);
    end;
  close(acciones);
  close(secuencia)
 End; {procedure creaSecuencia}

PROCEDURE reproducesecuencia(leer:String);
 VAR page:PageType; Graf2D,antiguo2D:Tgrafico2D;  secuencia:Tsecuencia;
  Begin
   initgraph;
   initpage(page);
   setActivePage(page);
   assign(secuencia,leer);
   reset(secuencia);
   if not EOF(secuencia) then read(secuencia,graf2D);
   while not EOF(secuencia) do
    Begin
    Antiguo2D:=graf2D;
    read(secuencia,graf2D);
    animacion(page,Antiguo2D,Graf2D);
    repeat until keypressed;
    End;
   close(secuencia);
  End; {procedure reproducesecuecia}







{ -------- Programa Principal  -------}


BEGIN
CREASECUENCIA('a:\ACCIONES.TXT','c:\hlocal\SECUENCIA.BIN');
REPRODUCESECUENCIA('c:\hlocal\SECUENCIA.BIN')
END.