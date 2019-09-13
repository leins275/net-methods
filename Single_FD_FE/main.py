import numpy as np
import matplotlib.pyplot as plt


def func(x):
    return x * (1 - x)


def create_uniform_net(a, b, n):
    h = (b - a) / n
    net = []

    for i in range(n):
        net.append(a + i * h)

    return net


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
            new_alpha = (- d[i] / (c[i] + b[i] * beta[i - 1]))
            new_beta = ((r[i] - b[i] * alpha[i - 1]) / (c[i] + b[i] * beta[i - 1]))
        alpha.append(new_alpha)
        beta.append(new_beta)

    # counting u values
    for i in range(n - 1, 0, -1):
        if i == n - 1:
            u[i] = un
            # u[i] = (r[i] - b[i] * beta[i - 1]) / (c[i] + b[i] * alpha[i - 1])
        else:
            u[i] = alpha[i] * u[i + 1] + beta[i]

    u[0] = 0
    return u


def fdm(n, u0, un, h):
    b = [-1] * n
    c = [2] * n
    d = [-1] * n
    r = [2 * h ** 2] * n

    r[0] = r[n - 1] = 0
    u = tridiagonal_matrix_alg(n, b, c, d, r, u0, un)

    return u


if __name__ == '__main__':
    a = 0
    l = 1
    n = 10
    h = (l - a) / n
    x = create_uniform_net(a, l, n)
    u = fdm(n, 0, 0, h)
    u.reverse()
    plt.plot(x, u)
    plt.show()
