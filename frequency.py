#!/usr/bin/env python
from numpy import *
from string import maketrans
from argparse import ArgumentParser


parser = ArgumentParser(add_help=True)
parser.add_argument("ciphertext", action="store",
                    help="<ciphertext string>")

opts = parser.parse_args()


def translator(text, alphabet, key):
    trantab = maketrans(alphabet, key)
    return text.translate(trantab)


def caesar_decode(ciphertext, s):
    alpha = "abcdefghijklmnopqrstuvwxyz"
    return translator(ciphertext, alpha, alpha[-s:] + alpha[:-s])


class frequency_analysis:
    def __init__(self, ciphertext):
        self.cor = [0.64297, 0.11746, 0.21902, 0.33483, 1.00000, 0.17541,
                    0.15864, 0.47977, 0.54842, 0.01205, 0.06078, 0.31688,
                    0.18942, 0.53133, 0.59101, 0.15187, 0.00748, 0.47134,
                    0.49811, 0.71296, 0.21713, 0.07700, 0.18580, 0.01181,
                    0.15541, 0.00583]
        self.ciphertext = ciphertext.lower()
        self.freq()
        self.min_error()
        self.key = self.minimum[0]
        self.solution = caesar_decode(self.ciphertext, self.minimum[0])

    def freq(self):
        self.arr = zeros(26)
        for l in self.ciphertext:
            x = ord(l)
            if (x >= 97 and x <= 122):
                self.arr[x - 97] += 1.0
        self.arr /= max(self.arr)

    def error(self):
        e = 0
        for i in range(0, len(self.arr)):
            e += abs(self.arr[i] - self.cor[i])**2
        return e

    def min_error(self):
        self.minimum = [0, 10000]
        for rot in range(0, 25):
            e = self.error()
            print rot, e
            if e < self.minimum[1]:
                self.minimum[1] = e
                self.minimum[0] = rot
            x = self.arr[-1]
            del self.cor[-1]
            self.cor.insert(0, x)


FA = frequency_analysis(opts.ciphertext)
print FA.solution
