import hashlib

# from some_bots import some_bots
from all_in_bot import all_in_bot
from zero_bot import zero_bot
from random_bot import random_bot
from average_bot import average_bot
from fortytwo_bot import fortytwo_bot



def decide_order(ls):
    hash = int(hashlib.sha1(str(ls).encode()).hexdigest(), 16) % 24
    nls = []
    for i in range(4, 0, -1):
        print(hash)
        nls.append(ls[hash % i])
        del ls[hash % i]
        hash //= i
    return nls


def auction(ls):
    global score, total
    pl = decide_order(sorted(ls))
    bots = [bot_list[i]() for i in pl]
    dollar = [0] * 4
    prev_win, prev_bid = -1, -1
    for rounds in range(10):
        bids = []

        for i in range(4):
            dollar[i] += 500

        for i in range(4):
            tmp_win = prev_win
            if prev_win == i:
                tmp_win = 0
            elif prev_win != -1 and prev_win < i:
                tmp_win += 1

            bid = int(bots[i].play_round(tmp_win, prev_bid))
            if bid < 0 or bid > dollar[i]:
                raise ValueError(pl[i])
            bids.append((bid, i))

        bids.sort(reverse = True)
        winner = 0
        if bids[0][0] == bids[1][0]:
            if bids[2][0] == bids[3][0]:
                winner = -1
            elif bids[1][0] == bids[2][0]:
                winner = 3
            else: winner = 2
        if winner == -1:
            prev_win, prev_bid = -1, -1
        else:
            prev_bid, prev_win = bids[winner]
            score[pl[prev_win]] += 1
            total[pl[prev_win]] += prev_bid
            dollar[prev_win] -= prev_bid

class TIE_REMOVED: pass


if __name__ == '__main__':

    bot_list = [all_in_bot,
                zero_bot,
                random_bot,
                average_bot,
                fortytwo_bot]

    N = len(bot_list)
    score = [0] * N
    total = [0] * N

    for a in range(N - 3):
        for b in range(a + 1, N - 2):
            for c in range(b + 1, N - 1):
                for d in range(c + 1, N):
                    auction([a, b, c, d])

    res = sorted(map(list, zip(score, total, bot_list)), key = lambda k: (-k[0], k[1]))


    for i in range(N - 1):
        if (res[i][0], res[i][1]) == (res[i + 1][0], res[i + 1][1]):
            res[i][2] = res[i + 1][2] = TIE_REMOVED
    for sc, t, tp in res:
        print('%-20s Score: %-6d Total: %d' % (tp.__name__, sc, t))

