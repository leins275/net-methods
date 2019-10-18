import numpy as np
from scipy import integrate
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


def tridiagonal_matrix_solve(n, b, c, d, r):
    v = [0] * n
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

    # counting v values
    for i in range(n - 1, 0, -1):
        if i == n - 1:
            # v[i] = r[i - 1]
            v[i] = (r[i] - b[i] * beta[i - 1]) / (c[i] + b[i] * alpha[i - 1])
        else:
            v[i] = alpha[i] * v[i + 1] + beta[i]

    return v


def fdm(n, u0, un, h):
    # build matrix
    b = [-1] * n
    c = [2] * n
    d = [-1] * n
    r = [2 * (h ** 2)] * n
    c[0] = 1
    c[n - 1] = 1
    d[0] = 0
    d[n - 1] = 0
    b[0] = 0
    b[n - 1] = 0
    r[0] = u0
    r[n - 1] = un

    # solve
    return tridiagonal_matrix_solve(n, b, c, d, r)


def fem(n, u0, un, h):
    b = [0] * n
    c = [0] * n
    d = [0] * n
    r = [0] * n
    # solve
    return tridiagonal_matrix_solve(n, b, c, d, r)


if __name__ == '__main__':
    a = 0  # interval begin
    l = 1  # interval end
    n = 1000  # num of nodes
    h = (l - a) / n
    x, u = create_uniform_net(a, l, n - 1)
    v = fdm(n, 0, 0, h)
    # u.reverse()

    print(h)
    plt.figure()
    plt.plot(x, u, 'r*')
    plt.plot(x, v, 'b--')
    plt.plot(x, v, 'bd')
    delta = []
    for i in range(len(x)):
        delta.append(abs(u[i] - v[i]))
    print(max(delta))
    plt.plot(x, delta, 'k')
    plt.grid()
    plt.show()
