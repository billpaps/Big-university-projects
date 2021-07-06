from myrand import myrand

class random_bot:

    def __init__(self):
        self.dollar = 0
        self.random = myrand(1)

    def play_round(self, winner, win_amount):
        self.dollar += 500
        if winner == 0: self.dollar -= win_amount
        return self.random.randint(0, self.dollar)

