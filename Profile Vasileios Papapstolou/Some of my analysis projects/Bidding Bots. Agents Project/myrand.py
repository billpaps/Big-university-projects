class myrand:

    def __init__(self, seed):
        self.val = seed

    def randint(self, a, b):
        self.val = (self.val * 6364136223846793005 + 1) % (1 << 64)
        return (self.val >> 32) % (b - a + 1) + a
