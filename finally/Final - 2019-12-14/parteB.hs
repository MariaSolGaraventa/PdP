-- Se tiene la siguiente función:
funcion x y lista = (filter (> x) . map (\ f -> f y)) lista

-- 1) Explicar lo que hace y proponer mejoras en términos de expresividad.

x: parámetro que tiene comparable (> x) -> Eq x
y: parámetro que es utilizado por la función f. esa lambda es como decir ($ y)
lista: parámetro que es una lista de funciones 
funcion: recibe un Eq x, un y y una lista de funciones, y devuelve una lista

Procedimiento:
- Mapea la lista de funciones con ($ y)
- Filtra la lista mapeada por los valores que sean menores a x
- Devuelve una nueva lista mapeada y filtrada.

filtrarSegun minimo valor listaDeFunciones = (filter (> minimo) . map ($ valor)) listaDeFunciones

-- 2) ¿Sería posible evaluar la función con una lista infinita de modo que dicha evaluación termine? Justificar conceptualmente y plantear un ejemplo para fundamentar la respuesta.
No. Por más de que exista la lazy evaluation que nos permite converger a un resultado por más que después haya un error, en este caso no nos salva. map es una función que necesita evaluar la lista completa, por lo que rompería el programa utilizarla con listas infinitas. En el caso del filter, tendríamos problemas si la lista es "infinita hacia la izquierda" por el (> x).

Ejemplos:
Sí a la LE: all even [1...] 
            > false
            take 3 [1...]
            > [1, 2, 3]
No a la LE: map (* 2) [1...] 
            >... -- jamas terminaría
            filter (> 2) [1...]
            >... -- jamas terminaría
-- 3) Indicar cuáles de las siguientes expresiones son válidas. Para las que son válidas indicar además el tipo de retorno y para las que no son válidas justificar el motivo.
    a. funcion 3 "hola" [] -> No es válida ya que está mezclando tipos y nuestra función necesita un tipo homogéneo.
    b. funcion 3 7 -> Válida. Devuelve una función [funciones] -> [números]
    c. funcion "chau" "hola" [length] -> Válida. Devuelve una lista de strings.
