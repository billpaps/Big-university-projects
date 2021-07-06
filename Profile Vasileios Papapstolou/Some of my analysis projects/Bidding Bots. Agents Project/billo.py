class billo:

    def __init__(self):
        self.money = 0
        self.round = 0

    def play_round(self, winner, amount):
        self.money += 500
        self.round += 1

        if winner == 0:
            self.money -= 500

        if (self.round%2) == 0:
