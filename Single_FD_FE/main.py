import numpy as np
import matplotlib.pyplot as plt


def create_uniform_net(a, b, n):
    h = (b - a) / n
    net = []

    for i in range(n + 1):
        net.append(a + i * h)

    return net


def tridiagonal_matrix_alg(n, b, c, d, r, u0, un):
    u = [u0]

    delta_i = - d[0] / c[0]
    lambda_i = r[0] / c[0]

    for i in range(1, n):
        ui = (u[i - 1] - (r[i] - b[i] * lambda_i) / (c[i] + b[i] * delta_i)) * (c[i] - b[i] * delta_i) / d[i]
        if i != n - 1:
            lambda_i = (r[i] - b[i] * lambda_i) / (c[i] + b[i] * delta_i)
            delta_i = - d[i] / (c[i] + b[i] * delta_i)
        u.append(ui)

    u.append(un)  # (r[n] - b[n] * lambda_i) / (c[n] + b[n] * delta_i)
    return u


def fdm(n, u0, un):
    b = [1] * n
    c = [-2] * n
    d = [1] * n
    r = [-2] * n

    u = tridiagonal_matrix_alg(n, b, c, d, r, u0, un)

    return u


if __name__ == '__main__':
    a = 0
    l = 1
    n = 10
    # x = create_uniform_net(a, l, n)
    u = fdm(n, 0, 0)
    print(u)
