# Nave
- Es única
- Conoce a todos los jugadores
- Cuántos impostores hay
- Cuántos tripulantes hay

# Jugadores
- Son impostores o tripulantes
- Conoce su color
- Conoce su mochila (inicia vacía)
    - Los ítems son de un sólo uso
- Conoce su nivel de sospecha (inicia en 40)
- Conoce qué tareas debe realizar (pueden repetirse entre los jugadores)

# Consignas
1. Saber si un jugador es sospechoso. Esto sucede cuando su nivel de sospecha es mayor a 50. 
2. Hacer que un jugador busque un ítem. Como resultado, agrega el ítem que buscaba a su mochila. 

# Tareas
- Cuando se le pide a un impostor realizar una tarea, no hace nada
- Los tripulantes las realizan para arreglar la nave
- Cada vez que una tarea es realizada, el tripulante le debe informar a la nave
    - En ese momento la nave chequea si todas las tareas de todos los jugadores fueron completadas. Si es impostor, siempre dice que sí
        - Si sí, se lanza una excepción "Ganaron los tripulantes"
  
## Tareas Disponibles (podría haber más)
- *Arreglar el tablero eléctrico*​: requiere que el tripulante tenga una llave inglesa en su mochila. Al realizarse aumenta 10 puntos el nivel de sospecha. 
- *Sacar la basura*​: requiere que el tripulante tenga una escoba y una bolsa de consorcio en su mochila. Al realizarse disminuye 4 puntos el nivel de sospecha. 
- *Ventilar la nave​*: aumenta en 5 puntos el nivel de oxígeno de la nave. 

# Consignas

1. Saber si un jugador completó todas sus tareas.
2. Pedirle a un jugador que realice cualquier tarea pendiente de entre las que puede realizar. Recordar que los impostores no hacen nada, mientras que los tripulantes deben considerar que algunas tareas tienen restricciones. Por otro lado, si corresponde, debe informarse que ganaron los tripulantes. 

# Sabotajes