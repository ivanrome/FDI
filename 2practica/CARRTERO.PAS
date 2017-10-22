program carretera;
uses graph,crt;

procedure inicializacion;
var modo,maneja:integer;
begin
  maneja:=detect;
  InitGraph(maneja, modo,'');
  setviewport(0,0,640,480,true);
end; {inicializaci¢n}

procedure dibujaCarretera;
          Type Tdireccion= (adelante, arriba, abajo);
          Const
              min_ancho=5;
              max_ancho=10;
              min_largo=20;
              max_largo=50;
          Var x,y,w,z,aux: integer; dir: Tdireccion;
                   {x=coordenada "x" superior donde queda el gr fico
                    y=coordenada "y" superior donde queda el gr fico
                    w=coordenada "x" inferior donde queda el gr fico
                    z=coordenada "y" inferior donde queda el gr fico
                   }
             begin

              while not keypressed do begin
              w:=random(16); x:=random(16);
              while x=w do x:=random(16);
              setbkcolor(w);
              setcolor(x);
              y:=random(240)+120;{genera una"y"entre 120 y 360}
              z:=y+5;
              w:=30; x:=30;
              line(0,y,x,y); line(0,z,w,z);
              dir:=adelante;
              while (y<480) or (z>0) or ((x<640) and (w<640)) do
               begin
                case dir of
                  arriba: begin
                         aux:=random(max_ancho-min_ancho)+min_ancho;
                         line(x,y,x,y-aux); y:=y-aux;
                         aux:=random(max_largo-min_largo)+min_largo;
                         line(w,z,w+aux,z); w:=w+aux;
                         line(x,y,w,y); x:=w; dir:=adelante;
                         end; {arriba}
                  abajo: begin
                         aux:=random(max_ancho-min_ancho)+min_ancho;
                         line(w,x,w,z+aux); z:=z+aux;
                         aux:=random(max_largo-min_largo)+min_largo;
                         line(x,y,x+aux,y); x:=x+aux;
                         line(w,z,x,z); w:=x; dir:=adelante;
                         end;  {abajo}
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
                  end;{case}
                end;{while}
                end;  end;
                end;

begin
randomize;
inicializacion;
dibujaCarretera;
end.