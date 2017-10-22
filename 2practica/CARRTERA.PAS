program carretera;
uses graph,crt;

procedure inicializacion;
var modo,maneja:integer;
begin
  maneja:=detect;
  InitGraph(maneja, modo,'c:\tp\bgi');
  setviewport(0,0,640,480,true);
end; {inicializaci¢n}

procedure dibujaCarretera;
          Const
              min_ancho=15;
              max_ancho=30;
              min_largo=15;
              max_largo=20;
          Var x,y,z: integer;
                   {x=coordenada "x" donde queda el gr fico
                    y=coordenada "y" superior donde queda el gr fico
                    z=coordenada "y" inferior donde queda el gr fico
                   }
          Type direccion= (adelante, abajo, arriba);
          procedure HaciaArriba(x,y,z:integer);
                    {continua el recorrido si toca hacia arriba}
                    var aux,w:integer;
                    begin
                    aux:=random(max_largo-min_largo)+min_ancho;
                    line(x,z,x+aux,z);
                    w:=random(max_ancho-min_ancho)+min_ancho;
                    line(x+aux,z,x+aux,z-w);
                    line(x,y,x,z-w);
                    y:=z-w;
                    end;

          procedure HaciaAbajo(x,y,z:integer);
                    {continua el recorrido si toca hacia abajo}
                    var aux,w:integer;
                    begin
                    aux:=random(max_largo-min_largo)+min_ancho;
                    line(x,y,x+aux,y);
                    w:=random(max_ancho-min_ancho)+min_ancho;
                    line(x+aux,y,x+aux,y+w);
                    line(x,z,x,w+y)
                    end;
          begin
              setbkcolor(red);
              setcolor(yellow);
              y:=random(240);  y:=y+115; {genera una"y"entre 115 y 355}
              x:=20;
              z:=y+random(max_largo-min_largo)+min_ancho;
              line(0,y,x,y); line(0,z,x,z);
              {while ((x<640)or(y<480)or(y>0)) do}
              if random(2)=1 then HaciaArriba(x,y,z)
                             else HaciaAbajo(x,y,z) ;
              repeat until keypressed;
           end;

begin
randomize;
inicializacion;
dibujaCarretera;
end.