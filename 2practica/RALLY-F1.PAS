PROGRAM carretera;
uses graph,crt;

PROCEDURE inicializacion; {inicia el programa en modo gr ficos}
var modo,maneja:integer;
begin
  maneja:=detect;
  InitGraph(maneja, modo,'c:\hlocal');
  setviewport(0,0,640,480,true);
end; {inicializaci¢n}

PROCEDURE dibujaCarretera (var inicio:integer);
{este procedimiento,como su nombre indica,dibuja la carretera sobre la que posteriormente correremos}
          Type Tdireccion= (adelante, arriba, abajo);
          Const
              min_ancho=10;
              max_ancho=25;
              min_largo=5;
              max_largo=75;
          Var x,y,w,z,aux: integer; dir: Tdireccion;
                   {x=coordenada "x" superior donde queda el gr fico
                    y=coordenada "y" superior donde queda el gr fico
                    w=coordenada "x" inferior donde queda el gr fico
                    z=coordenada "y" inferior donde queda el gr fico
                   }
             BEGIN  {dibujaCarretera}
              setbkcolor(random(4));
              setcolor(random(2)+14); {elige entre amarillo y blanco}
              y:=random(240)+120;{genera una"y"entre 120 y 360}
              inicio:=y+min_ancho div 2;
              z:=y+min_ancho;
              w:=30; x:=30;
              line(0,y,x,y); line(0,z,w,z);
              dir:=adelante; {inicializaci¢n del while}
              while (y<480) and (z>0) and ((x<640) or (w<640)) do
                case dir of
                  adelante: begin
                            if random(2)=0 then
                                         begin
                                         dir:=arriba;
                                         aux:=(max_ancho-min_ancho)+min_ancho;
                                         line(w,z,w+aux,z); w:=w+aux;
                                         aux:=random(max_largo-min_largo)+min_largo;
                                         line(x,y,x,y-aux); y:=y-aux;
                                         line(w,z,w,y); z:=y;
                                         end  {if-then}
                                            else
                                         begin
                                         dir:=abajo;
                                         aux:=(max_ancho-min_ancho)+min_ancho;
                                         line(x,y,x+aux,y); x:=x+aux;
                                         aux:=random(max_largo-min_largo)+min_largo;
                                         line(w,z,w,z+aux); z:=z+aux;
                                         line(x,y,x,z); y:=z;
                                         end ;  {if-else}
                         end; {adelante}
                  arriba: begin
                         aux:=random(max_ancho-min_ancho)+min_ancho;
                         line(x,y,x,y-aux); y:=y-aux;
                         aux:=random(max_largo div 2 -min_largo div 2)+min_largo div 2;
                         line(w,z,w+aux,z); w:=w+aux;
                         line(x,y,w,y); x:=w; dir:=adelante;
                         end; {arriba}
                  abajo: begin
                         aux:=random(max_ancho-min_ancho)+min_ancho;
                         line(w,z,w,z+aux); z:=z+aux;
                         aux:=random(max_largo div 2-min_largo div 2)+min_largo div 2;
                         line(x,y,x+aux,y); x:=x+aux;
                         line(w,z,x,z);w:=x; dir:=adelante;
                         end;  {abajo}
                END;{case- while}
              END;{procedure dibujacarretera}


PROCEDURE juego(inicio,retraso:integer);
{Sea un punto que se mueve trazando una estela,se manejar  para que no se salga de la carretera}

Type tecla =(arriba, abajo, izquierda, derecha, nada);
Var Xpunto, Ypunto: integer; dir: tecla; fin:boolean;
  FUNCTION leetecla: tecla;
      BEGIN        {function leetecla}
      if not keypressed then leetecla:=nada
                        else if ord(readkey)<>0 then leetecla:=nada
                                                else case ord (readkey) of
                                                          77: leetecla := derecha ;
                                                          80: leetecla := abajo   ;
                                                          72: leetecla := arriba  ;
                                                          75: leetecla := izquierda;
                                                     END {case}
      END {function leetecla};
  PROCEDURE MOVER (var xpunto,ypunto:integer; var dir: tecla);
     BEGIN
               case leetecla of
                    nada:
                        case dir of
                              derecha:
                                      begin
                                      Xpunto:=Xpunto+1;
                                      if getpixel (xpunto, ypunto) < 3 then putpixel(xpunto,ypunto,red)
                                                                       else fin:=true
                                      end;
                              abajo:
                                      begin
                                      ypunto:=ypunto+1;
                                      if getpixel (xpunto, ypunto) < 3 then putpixel(xpunto,ypunto,red)
                                                                       else fin:=true;
                                      end;
                              arriba:
                                      begin
                                      ypunto:=ypunto-1;
                                      if getpixel (xpunto, ypunto) < 3 then putpixel(xpunto,ypunto,red)
                                                                       else fin:= true;
                                      end;
                              izquierda:
                                      begin
                                      xpunto:=xpunto-1;
                                      if getpixel (xpunto, ypunto) < 3 then putpixel(xpunto,ypunto,red)
                                                                       else fin:= true;
                                      end;
                          end;
                    derecha:
                         if dir <> izquierda then dir:= derecha;

                    arriba:
                         if dir <> abajo then dir:= arriba;

                    abajo:
                         if dir <> arriba then dir:= abajo;

                    izquierda:
                         if dir <> derecha then dir:= izquierda;
               END;{case }
    delay (retraso);
    END;

  BEGIN {procedure juego}
    xpunto:=0; ypunto:=inicio;
    putpixel (xpunto,ypunto,red);
    dir:=derecha; fin:= false;
    while ((ypunto<480) and (ypunto>0) and (xpunto<640) and (xpunto<640) and not fin) do
          mover(xpunto,ypunto,dir);

  setcolor(random(12)+4);
  if fin=false then outtextXY(random(500)+5,random(450)+5,'you are the champion')
               else outtextXY(10,10,'has perdido');
  delay (1000);

 END; {procedure juego}



var inicio,retraso:integer;
BEGIN
randomize;
writeln('                             ¨qu‚ retraso quieres?');
write('                                  ');
readln(retraso);   {para seleccioner retraso}
inicializacion;
dibujaCarretera (inicio);
repeat until keypressed;
juego(inicio,retraso)
END.