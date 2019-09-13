import numpy as np
import matplotlib.pyplot as plt


def func(x):
    return x * (1 - x)


def create_uniform_net(a, b, n):
    h = (b - a) / n
    net = []
    f = []

    for i in range(n + 1):
        new_p = a + i * h
        net.append(new_p)
        f.append(func(new_p))
    return net, f


def tridiagonal_matrix_alg(n, b, c, d, r, u0, un):
    u = [0] * n
    beta = []
    alpha = []

    # setting up alpha and beta
    for i in range(n):
        if i == 0:
            new_alpha = r[0] / c[0]
            new_beta = - d[0] / c[0]
        else:
            new_alpha = (- d[i] / (c[i] + b[i] * alpha[i - 1]))
            new_beta = ((r[i] - b[i] * beta[i - 1]) / (c[i] + b[i] * alpha[i - 1]))
        alpha.append(new_alpha)
        beta.append(new_beta)

    # counting u values
    for i in range(n - 1, 0, -1):
        if i == n - 1:
            u[i] = un
            # u[i] = (r[i] - b[i] * beta[i - 1]) / (c[i] + b[i] * alpha[i - 1])
        else:
            u[i] = alpha[i] * u[i + 1] + beta[i]

    return u


def fdm(n, u0, un, h):
    b = [-1] * n
    c = [2] * n
    d = [-1] * n
    r = [2 * h ** 2] * n

    return tridiagonal_matrix_alg(n, b, c, d, r, u0, un)


if __name__ == '__main__':
    a = 0
    l = 1
    n = 11
    h = (l - a) / n
    x, y = create_uniform_net(a, l, n - 1)
    u = fdm(n, 0, 0, h)
    # u.reverse()

    plt.figure()
    plt.plot(x, y, 'r*')
    plt.plot(x, u, 'b--')
    plt.plot(x, u, 'bd')
    plt.grid()
    plt.show()
