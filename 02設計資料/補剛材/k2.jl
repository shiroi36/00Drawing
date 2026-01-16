using Printf

println("横補剛材K2の検討")
println("使用鋼材: SS400")

e = 205000.0 # N/mm2
@printf("	ヤング係数	E = %.0fN/mm2\n", e)

println("")

println("補剛対象の梁: H-800x300x14x26(SS400)")

lg = 10200.0 # mm
@printf("	梁長さ		lg = %.0fmm\n", lg)

sigma_y = 235.0 # N/mm2
@printf("	短期許容応力度	F = %.0fN/mm2\n", sigma_y)

a = 263.5e2 # mm2
@printf("	断面積		A = %.0fmm2\n", a)

c = sigma_y * a / 2 # N
@printf("	圧縮側合力	C = F・A/2 = %.1fkN\n", c / 1e3)

iyy = 11700e4 # mm4

iy = sqrt(iyy / a) # mm
@printf("	弱軸断面二次半径	iy = %.2fcm\n", iy / 1e1)

println("")

println("補剛材: 2L-65x65x6(2-M16, S10T)")

lb = 3400.0 # mm
@printf("	横補剛間隔			lb = %.0fmm\n", lb)

n = 2
@printf("	横補剛数				n = %d\n", n)

ak = 2 * (7.527 * 1e2 - 6 * 18) # mm2
@printf("	断面積（ボルト孔控除）		Ak = %.0fmm2\n", ak)

lk = sqrt(800^2 + 2625^2) # mm
@printf("	補剛材長さ			lk = %.0fmm\n", lk)

ik = 19.8 # mm
@printf("	補剛材の断面二次半径		ik = %.2fcm\n", ik / 1e1)

lambda_k = lk / ik
@printf("	補剛材の細長比			λk = %.0f\n", lambda_k)

fc = 48.3 * 1.5
@printf("	補剛材の短期許容圧縮応力度	fc = %.1fN/mm2\n", fc)

nb = 2
@printf("	ボルト本数			nb = %d\n", nb)
qa = 1.5 * 30.2e3 # N
@printf("	ボルト1本あたり許容せん断力	qa = %.1fkN\n", qa / 1e3)

println("")

println("(1) 補剛区間長さの検討")
lhs = lg / iy
rhs = 170 + 20 * n
@printf("	細長比	λ = lg/iy = %.0f < 170 + 20n = %d...OK\n", lhs, rhs)
println("")

println("(2) 補剛力の検討")

fd = 0.02 * c / cos(15 / 180 * pi) # N
@printf("	必要補剛力	Fd = 0.02・C / cos(15°) = %.1fkN\n", fd / 1e3)

fa = fc * ak # N
@printf("	補剛材耐力	Fa = fc・Ak = %0.1fkN", fa / 1e3)
println(fa > fd ? " > Fd...OK" : " < Fd...NG")

println("")

println("(3) 補剛剛性の検討")

kd = 5 * c / lb / cos(15 / 180 * pi)
@printf("	必要剛性		Kd = 5・C/lb / cos(15°) = %.1fkN/mm\n", kd / 1e3)

k = e * ak / lk # N/mm
@printf("	補剛材軸剛性	K = E・Ak/lk = %0.1fkN/mm", k / 1e3)
println(k > kd ? " > Kd...OK" : " < Kd...NG")

println("")

println("(4) 接合部の検討")

qb = fd / nb # N
@printf("	ボルト1本あたりせん断力	qb = Fd/nb = %.1fkN", qb / 1e3)
println(qb < qa ? " < qa...OK" : " > qb...NG")

ae = (100 - 18) * 12 # mm
@printf("	GPL-12x100有効断面積	Ae = %.1fmm\n", ae)
fsj = 136 # N/mm2
@printf("	GPL短期許容せん断応力度	fsj = %.1fN/mm2\n", fsj)
qaj = ae * fsj # N
@printf("	GPL短期許容せん断力	Qaj = %.1fkN", qaj / 1e3)
println(qaj > fd ? " > Fd...OK" : " < Fd...NG")
