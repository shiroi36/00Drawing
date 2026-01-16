using Printf

@printf("(1) 使用材料\n")
ft = 157 # N/mm2
e = 205000 # N/mm2
@printf("	SS400		ft = %.0f N/mm2, E = %.1f N/mm2\n", ft, e)

@printf("\n")

@printf("(2) 設計荷重\n")
wd = 2500e-6 # N/mm2
wl = 1800e-6 # N/mm2
w0 = wd + wl # N/mm2
@printf("	DL		%.0f N/m2\n", wd * 1e6)
@printf("	LL (床用)	%.0f N/m2\n", wl * 1e6)
@printf("	TL		%.0f N/m2\n", w0 * 1e6)

@printf("\n")

@printf("(3) 側桁の検討\n")
b = 450.0 # mm
l = 6100.0 # mm
@printf("	側桁PL-16×300について、負担幅B=%.2fmスパンL=%.1fmの単純梁として検討する。\n", b / 1e3, l / 1e3)
ix = 3600e4 # mm4
@printf("	断面二次モーメント	I = %.0f cm4\n", ix / 1e4)
z = 240e3 # mm3
@printf("	断面係数			Z = %.0f cm3\n", z / 1e3)
w = w0 * b # N/mm
@printf("	等分布荷重	w = %.1f kN/m2×%.2fm = %.1f kN/m\n", w0 * 1e3, b / 1e3, w)
md = w * l^2 / 8 # Nmm
@printf("	設計曲げモーメント	Md = 1/8・w・L^2 = %.2f kNm\n", md / 1e6)
ma = ft * z # Nmm
@printf("	長期許容曲げモーメント	Ma = ft・Z = %.2f kNm\n", ma / 1e6)
rate1 = md / ma
@printf("	検定比			Ma / Md = %.2f", rate1)
println(rate1 < 1 ? " < 1.0...OK" : " > 1.0...NG")
delta = 5 * w * l^4 / 384 / e / ix
rate2 = l / delta
@printf("	たわみ			δ = 5・w・L^4/384/E/I = %.1f mm = L/%.0f", delta, rate2)
println(rate2 > 250 ? " < L/250...OK" : " > L/250...NG")

@printf("\n")

@printf("(4) 側桁接合部の算定\n")
@printf("	GPL-16(SS400, 80x200)、3-M20(F8T)として検討する。\n")
qd = w * l / 2 # N
@printf("	設計せん断力		Qd = w・L/2 = %.2f kN\n", qd / 1e3)
qa = 21.4e3 # N
nb = 2
qa1 = nb * qa # N
@printf("	ボルト長期許容せん断力	Qa1 = %d×%.1f kN = %.1f kN\n", nb, qa / 1e3, qa1 / 1e3)
tg = 16.0 # mm
lg = 80.0 #mm
db = 22.0 # mm
qa2 = ft / sqrt(3) * tg * (lg - db) # N
@printf("	GPL長期許容せん断力	Qa2 = %.0f N/mm2/√3×%.0f mm×(%.0f mm - %.0f mm) = %.1f kN\n", ft, tg, lg, db, qa2 / 1e3)
rate3 = qd / min(qa1, qa2)
@printf("	検定比			Qd/min{Qa1, Qa2} = %.2f", rate3)
println(rate3 < 1 ? " < 1.0...OK" : " > 1.0...NG")
