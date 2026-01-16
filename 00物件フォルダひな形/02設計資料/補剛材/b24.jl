using Printf

println("横補剛材B24の検討")
println("使用鋼材: SS400")

e = 205000.0 # N/mm2
@printf("	ヤング係数	E = %.0fN/mm2\n", e)

println("")

println("補剛対象の梁: H-390x300x10x16(SS400)")

lg = 10200.0 # mm
@printf("	梁長さ		lg = %.0fmm\n", lg)

sigma_y = 235.0 # N/mm2
@printf("	短期許容応力度	F = %.0fN/mm2\n", sigma_y)

a = 133.3e2 # mm2
@printf("	断面積		A = %.0fmm2\n", a)

c = sigma_y * a / 2 # N
@printf("	圧縮側合力	C = F・A/2 = %.1fkN\n", c / 1e3)

iyy = 7200e4 # mm4

iy = sqrt(iyy / a) # mm
@printf("	弱軸断面二次半径	iy = %.2fcm\n", iy / 1e1)

println("")

println("補剛材: H-248x124x5x8(2x2-M20)")

lb = 3400.0 # mm
@printf("	横補剛間隔			lb = %.0fmm\n", lb)

n = 2
@printf("	横補剛数				n = %d\n", n)

ak = 31.99e2 - 2* 5 * 22 # mm2
@printf("	断面積（ボルト孔控除）		Ak = %.0fmm2\n", ak)

lk = 5250 # mm
@printf("	補剛材長さ			lk = %.0fmm\n", lk)

ik = 2.82e1 # mm
@printf("	補剛材の断面二次半径		ik = %.2fcm\n", ik / 1e1)

lambda_k = lk / ik
@printf("	補剛材の細長比			λk = %.0f\n", lambda_k)

fc = 65.9 * 1.5
@printf("	補剛材の短期許容圧縮応力度	fc = %.1fN/mm2\n", fc)

println("")

println("(1) 補剛区間長さの検討")
lhs = lg / iy
rhs = 170 + 20 * n
@printf("	細長比	λ = lg/iy = %.0f < 170 + 20n = %d...OK\n", lhs, rhs)
println("")

println("(2) 補剛力の検討")

fd = 0.02 * c # N
@printf("	必要補剛力	Fd = 0.02・C = %.1fkN\n", fd / 1e3)

fa = fc * ak # N
@printf("	補剛材耐力	Fa = fc・Ak = %0.1fkN", fa / 1e3)
println(fa > fd ? " > Fd...OK" : " < Fd...NG")

println("")

println("(3) 補剛剛性の検討")
println("B35Sの弱軸曲げにより、G4の横補剛がなされていると考える。この時、B35Sの弱軸方向は中央部がピン支持された長さlg=10200mmの両端ピン梁と考える。B24がとりつく端部からlg/3位置(=3400mm位置)と2lg/3位置(=6800mm位置)に加力する際の剛性は(4)の検討により34992/22・E・Iy/lg^3である。必要剛性Kdに対して、補剛剛性Kは以下となる。")

kd = 5 * c / lb 
@printf("	必要剛性		Kd = 5・C/lb = %.1fkN/mm\n", kd / 1e3)

iyyb = 984e4 # mm4
@printf("	B35S弱軸断面二次モーメント	Iy = %.1fcm4\n", iyyb / 1e4)

k = 34992 / 22 * e * iyyb / lg^3 # N/mm
@printf("	補剛材軸剛性	K = 34992/22・E・Iy/lg^3 = %0.1fkN/mm", k / 1e3)
println(k > kd ? " > Kd...OK" : " < Kd...NG")

println("")

