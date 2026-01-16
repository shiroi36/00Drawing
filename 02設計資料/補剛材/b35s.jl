using Printf

println("B35S方杖の横補剛の検討")
println("使用鋼材: SS400")

e = 205000.0 # N/mm2
@printf("	ヤング係数	E = %.0fN/mm2\n", e)

println("")

println("補剛対象の梁: H-900x300x16x28(SM490A)")

lg = 10200.0 # mm
@printf("	梁長さ		lg = %.0fmm\n", lg)

sigma_y = 325.0 # N/mm2
@printf("	短期許容応力度	F = %.0fN/mm2\n", sigma_y)

a = 305.8e2 # mm2
@printf("	断面積		A = %.0fmm2\n", a)

c = sigma_y * a / 2 # N
@printf("	圧縮側合力	C = F・A/2 = %.1fkN\n", c / 1e3)

iy = 6.43e1 # mm
@printf("	弱軸断面二次半径	iy = %.2fcm\n", iy / 1e1)

println("")

println("補剛材: 2L-75x75x6(2-M16, S10T)")

lb = 3400.0 # mm
@printf("	横補剛間隔			lb = %.0fmm\n", lb)

n = 2
@printf("	横補剛数				n = %d\n", n)

ak = 2 * (8.727 * 1e2 - 6 * 18) # mm2
@printf("	断面積（ボルト孔控除）		Ak = %.0fmm2\n", ak)

lk = sqrt(2.0) * (900 - 350) # mm
@printf("	補剛材長さ			lk = %.0fmm\n", lk)

ik = 23.0 # mm
@printf("	補剛材の断面二次半径		ik = %.2fcm\n", ik / 1e1)

lambda_k = lk / ik
@printf("	補剛材の細長比			λk = %.0f\n", lambda_k)

fc = 148.0 * 1.5
@printf("	補剛材の短期許容圧縮応力度	fc = %.1fN/mm2\n", fc)

println("")

println("受け材B35: H-350x175x7x11")
ix = 13500.0 * 1e4 # mm4
@printf("	断面二次モーメント		I = %.0fcm4\n", ix / 1e4)

lm = 5250.0 # mm
@printf("	部材長さ		lm = %.0fmm\n", lm)

nb = 2
@printf("	ボルト本数			nb = %d\n", nb)
qa = 1.5 * 60.3e3 # N
@printf("	ボルト1本あたり許容せん断力	qa = %.1fkN\n", qa / 1e3)

println("")

println("(1) 補剛区間長さの検討")
lhs = lg / iy
rhs = 130 + 20 * n
@printf("	細長比	λ = lg/iy = %.0f < 130 + 20n = %d...OK\n", lhs, rhs)
println("")

println("(2) 補剛力の検討")

fd = 0.02 * c / cos(45 / 180 * pi) # N
@printf("	必要補剛力	Fd = 0.02・C / cos45° = %.1fkN\n", fd / 1e3)

fa = fc * ak # N
@printf("	補剛材耐力	Fa = fc・Ak = %0.1fkN", fa / 1e3)
println(fa > fd ? " > Fd...OK" : " < Fd...NG")

println("")

println("(3) 補剛剛性の検討")

kd = 5 * c / lb / cos(45 / 180 * pi)
@printf("	必要剛性		Kd = 5・C/lb / cos45° = %.1fkN/mm\n", kd / 1e3)

le = 900.0 # mm
@printf("	横力偏心距離（補剛対象梁せい）		le = %.1fmm\n", le)
# theta = M * L / 3EI
# d = fd * le * lm / 3EI * le
k = 3 * e * ix / le / le / lm
@printf("	B39回転剛性	K = 3・E・I/lm/le^2 = %0.1fkN/mm", k / 1e3)
println(k > kd ? " > Kd...OK" : " < Kd...NG")

println("")

println("(4) 接合部の検討")

qb = fd / nb # N
@printf("	ボルト1本あたりせん断力	qb = Fd/nb = %.1fkN", qb / 1e3)
println(qb < qa ? " < qa...OK" : " > qb...NG")

ae = (120 - 18) * 12 # mm
@printf("	GPL-12x120有効断面積	Ae = %.1fmm\n", ae)
fsj = 136 # N/mm2
@printf("	GPL短期許容せん断応力度	fsj = %.1fN/mm2\n", fsj)
qaj = ae * fsj # N
@printf("	GPL短期許容せん断力	Qaj = %.1fkN", qaj / 1e3)
println(qaj > fd ? " > Fd...OK" : " < Fd...NG")
