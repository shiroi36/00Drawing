using Printf


af = 67.6 # m2
@printf("かさ上げ部床面積	Af = %.1fm2\n", af)

w0 = 4.8 + 0.3 + 1.8
w = w0 * af
@printf("かさ上げ部常時荷重	W = %.1fkN/m2×%.1fm2 = %.1fkN\n", w0, af, w)

q = 0.2 * w
@printf("地震時水平力	Q = 0.2×%.1fkN = %.1fkN\n", w, q)

aw = 0.15 * (5.6 + 5.6 + 6.8) # m2
@printf("壁断面積	Aw = 0.15m×(5.6m + 5.6m + 6.8m) = %.1fm2\n", aw)

tau = q * 1e3 / aw / 1e6
@printf("せん断応力度	τ = %.1fkN / %.1fm2 = %.3fN/mm2\n", q, aw, tau)

fs = 1.4
@printf("短期許容せん断応力度	fs = %.1fN/mm2 > τ → 【OK】\n", fs)

