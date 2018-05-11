use<CASEgamma.scad>
use<boards.scad>
use<Utilities.scad>

   
     /*
    medidas Rasberry Pi
     eje "x"= 85mm
     eje "y"= 56mm
      espesorTarjeta=1.6
    */
    
   // translate([-85/2,-56/2,-90+3])
   // RaspberryPi();
    
    diametroPosteRaspberry=6;
    tornilloRaspberry=2.75;
    alturaPostesRaspberry=10;
    //parte=1;
    
       
 /*   module recortadorMink(lonX=20,lonY=20,lonZ=20,esf=1){
        minkowski(){
        cube([lonX-(2*esf),lonY-(2*esf),lonZ-(2*esf)],center=true);
            sphere(r=esf,$fn=100);
            }
    }*/
   

//PARTE CONTENEDORA
module CASEsat(){
//if(parte==1){
    difference(){
CASEgamma(lonX=90,lonY=90,lonZ=180,espesor=1.5,diametroPoste=5,tornillo=2.5,parte=1);
     
     //taladroRaspberry
       translate([-85/2,-56/2,-90+1.5+(alturaPostesRaspberry/2)])
    RaspberryPi(); 
      
       //Recorte postes
    translate([0,0,-35])
    cube([90-3,90-3,50],center=true);
        
        //recortes Laterales
        
        //inicial
          translate([45,0,-33])
           recortadorMink(75,75,50,15);
        
      /*  for(i=[1:3]){
            rotate(90*i)
            translate([45,0,-45])
           recortadorMink(75,75,75,15);
        }*/
        
    
    }//fin difference
    




   //###TornillosRaspberry#####
translate([-85/2,-56/2,-90+1.5+(alturaPostesRaspberry/2)])
union(){
translate([3.5,3.5,0])
rotate([180,0,0])
poste(diametroPosteRaspberry,tornilloRaspberry,alturaPostesRaspberry);


translate([3.5+58,3.5,0])
rotate([180,0,0])
poste(diametroPosteRaspberry,tornilloRaspberry,alturaPostesRaspberry);

translate([3.5,3.5+49,0])
rotate([180,0,0])
poste(diametroPosteRaspberry,tornilloRaspberry,alturaPostesRaspberry);    
    
translate([3.5+58,3.5+49,0])
rotate([180,0,0])
    poste(diametroPosteRaspberry,tornilloRaspberry,alturaPostesRaspberry);
}//fin union tornillos


//}
//fin parte 1 (CONTENEDORA)

}//fin CASE sat


module TAPAsat(){

    
    medidaTriangulo=15;
    distanciaTriangulos=9;
        difference(){
           CASEgamma(lonX=90,lonY=90,lonZ=6,espesor=1.5,diametroPoste=5,tornillo=2.5,parte=1);
           //recortadorMink(75,75,75,15);
            
            
            //Reocrtadores tipo triangulo alrededor del centro
            for(i=[0:3]){
                   
                rotate(90*i)
                   union(){
                     translate([-medidaTriangulo*2.4,distanciaTriangulos,-medidaTriangulo/2])
                     linear_extrude(height=medidaTriangulo)
                     recortadorMinkPoly(medidaTriangulo,medidaTriangulo,5);
            
                     mirror([0,1,0]){
                       translate([-medidaTriangulo*2.4,distanciaTriangulos,-medidaTriangulo/2])
                       linear_extrude(height=medidaTriangulo)
                       recortadorMinkPoly(medidaTriangulo,medidaTriangulo,5);
                    }
                 }
            
              }      
             
     
                    cylinder(r=10,$fn=100,h=20,center=true);         
                
        }
        
 
 
 }//fin tapa sat
 
  module BASEsensores(){
     
 tornillo=2.5;
 diametroPoste=5;
 lonX=90;
 lonY=90;
 espesor=1.5;
      
      difference(){
   linear_extrude(height=1.5)
difference(){
    

    //espacioes entre miniProto=36mm
    
    
    panelMatriz(lonX-(2*espesor),lonY-(2*espesor),taladro=3.5/2,divisiones=(lonX-(2*espesor))/36);
    echo((lonX-(2*espesor))/36);
    //circle(r=12,$fn=100);
    
    //Poste (1,1)
translate([-diametroPoste+lonX/2,-diametroPoste+lonY/2])
//poste(diametroPoste,tornillo,lonZ-(3*espesor/4),0);
    circle(r=tornillo/2,$fn=100);

//Poste (-1,1)
translate([-diametroPoste+lonX/2,+diametroPoste-lonY/2])
  circle(r=tornillo/2,$fn=100);

//Poste (1,-1)
translate([diametroPoste-lonX/2,-diametroPoste+lonY/2])
  circle(r=tornillo/2,$fn=100);

//Poste (-1,-1)
translate([diametroPoste-lonX/2,diametroPoste-lonY/2])
  circle(r=tornillo/2,$fn=100);

}

//DIFFERENCE 3D
//taladroRaspberry
        translate([-85/2,-56/2,-30+1.5+(alturaPostesRaspberry/2)])
        RaspberryPi(20); 


}

}//fin module base sensores
 
 
 //#######RENDERIZADOS########
 
CASEsat();
 
rotate([180,0,0]) 
TAPAsat();

translate([0,0,-60])
BASEsensores();
 

