# 等分布荷重を受ける片持ち鉄骨梁の検討

using Printf

sec = "□-200x200x4.5"
@printf("断面				%s\n", sec)

z = 219e3
@printf("断面係数			Z=%.0fcm3\n", z * 1e-3)

l = 1635
@printf("部材長さ			L=%.0fmm\n", l)

lb = l * 2
@printf("圧縮フランジの支点間距離	Lb=%.0fmm\n", lb)

fb = 235
@printf("短期許容曲げ応力度		fb=%.0fN/mm2\n", fb)

b = 1.55e3
@printf("支配幅			b=%.1fm\n", b * 1e-3)

w0 = 1.9e-3
w = w0 * b
@printf("等分布荷重			w=%.2fkN/m2×%.1fm=%.1fkN/m\n", w0 * 1e3, b * 1e-3, w)

m = w * l^2 / 2
@printf("設計曲げモーメント		M=w・L^2/2=%.1fkN/m×%.2fm^2/2=%.1fkNm\n", w, l * 1e-3, m * 1e-6)

sigma_b = m / z
@printf("曲げ応力度			σb=M/Z=%.1fkNm/%.0fcm3=%.1fN/mm2\n", m * 1e-6, z * 1e-3, sigma_b)

rate = sigma_b / fb
@printf("検定				σb/fb=%.3f→【OK】\n", rate)

i = 2190e4
@printf("断面二次モーメント		I=%.0fcm4\n", i * 1e-4)

e = 205000
delta = w * l^4 / 8 / e / i
@printf("先端たわみ	δ=w・L^4/(8EI)=%.1fkN/m×%.0fmm^4/(8×%.0fN/mm2×%.0fcm4)=%.1fmm\n", w, l, e, i * 1e-4, delta)

rate = l / delta
@printf("検定				δ/L=1/%.0f<1/250→【OK】\n", rate)
