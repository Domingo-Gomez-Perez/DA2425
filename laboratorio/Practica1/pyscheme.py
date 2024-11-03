# scheme.py
#
# Challenge: Can you implement a scheme interpreter in Python that's
# capable of executing the following procedure?

# A procedure definition for:
#
#   (define fact
#      (lambda (n) (if (= n 1)
#                   1
#                   (* n (fact (- n 1))))))
#
# It's represented in Python using the following tuple:

fact = (
    "define",
    "fact",
    ("lambda", ("n",), ("if", ("=", "n", 1), 1, ("*", "n", ("fact", ("-", "n", 1))))),
)


def pon_en_env(x, y):
    global env
    env[x] = y  # No evalúes el valor aquí, ya está evaluado.


env = {
    "+": lambda x, y: x + y,
    "-": lambda x, y: x - y,
    "*": lambda x, y: x * y,
    "=": lambda x, y: x == y,
}


def hacer_funcion(argumentos, cuerpo):
    def funcion(*valores):
        old_env = env.copy()  # Crear un entorno local
        for nombre, valor in zip(argumentos, valores):
            env[nombre] = valor  # Actualiza el entorno con los argumentos
        resultado = seval(cuerpo)  # Evalúa el cuerpo en el nuevo entorno
        env.update(old_env)  # Restaura el entorno original
        return resultado

    return funcion


def seval(sexp):
    if isinstance(sexp, int):
        return sexp
    elif isinstance(sexp, str):
        return env.get(
            sexp, sexp
        )  # Obtiene el valor del entorno o devuelve el símbolo.
    elif isinstance(sexp, tuple):
        if sexp[0] == "if":
            condicion = seval(sexp[1])
            if condicion:
                return seval(sexp[2])
            else:
                return seval(sexp[3])

        elif sexp[0] == "lambda":
            argumentos = sexp[1]
            cuerpo = sexp[2]
            return hacer_funcion(argumentos, cuerpo)
        elif sexp[0] == "define":
            nombre = sexp[1]
            valor = seval(sexp[2])  # Evalúa el valor a ser asignado
            pon_en_env(nombre, valor)
            return valor
        else:
            func = seval(sexp[0])  # Evalúa la función
            args = [seval(e) for e in sexp[1:]]  # Evalúa los argumentos
            return func(*args)


# Pruebas básicas
assert seval(42) == 42
assert seval(("+", ("+", 2, 1), 3)) == 6
seval(("define", "n", 5))
assert seval("n") == 5

# Ahora la prueba final: ejecutar el procedimiento fact.
seval(fact)
assert seval(("fact", "n")) == 120  # Cambié "n" a 5 para la prueba
