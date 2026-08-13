# Practica del paradigma Logico dado por la materia Paradigmas de Programacion en la UTN-FRBA.

## Contenidos vistos en este paradigma: 

### 1. Fundamentos y Sintaxis Básica
      Pensamiento Declarativo.
      Base de Conocimientos.
      Predicados e Individuos.
      Principio de Universo Cerrado (CWA).
### 2. Reglas, Unificación e Inversibilidad 
      Variables y Consultas: Consultas existenciales e individuales. Uso de la variable anónima (_).
      Unificación: Emparejamiento lógico de términos (diferente a la asignación imperativa de variables).
      Backtracking.
      Cláusulas de Horn.
      Inversibilidad.
### 3. Estructuras de Datos Compuestas 
      Aritmética y Evaluación.
      Listas.
      Functores.
### 4. Predicados de Orden Superior 
      Concepto.
      Negación por Falla (not/1 o \+).
      Cuantificación Universal (forall/2).
      Agrupación (findall/3).
### 5. Recursividad 🔄
      Tipos de Recursión: De dominio y estructural .
### 6. Diseño, Acoplamiento y Code Smells 
      Delegación y Responsabilidades.
      Code Smells.
      Duplicación de lógica o falta de aprovechamiento polimórfico de functores.
      Uso imperativo de listas.
      Findall-Member Smell.
      Lazy Predicate .
      Unificación intermedia / Incógnitas innecesarias.
### 7. Combinatoria y Conceptos Avanzados 🚀
      Mapeo de Colecciones (maplist).
      Evaluación Dinámica (call).
      Efecto Colateral: Manipulación en ejecución de la base de conocimientos con assert y retract.
### 8. Pruebas Unitarias con PlUnit 🧪
      Bloques de Pruebas: Delimitados por begin_tests(grupo) y end_tests(grupo).
      Determinismo: Manejo de advertencias de choicepoints mediante la opción nondet.
      Testeo de Negación: Verificación de fallas esperadas con la opción fail.
      Testeo de Inversibilidad: Comprobación del conjunto completo de soluciones usando la directiva set(Var == [Sol1, Sol2, ...]).
