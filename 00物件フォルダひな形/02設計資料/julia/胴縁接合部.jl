# 胴縁端部接合部の検討

qs = 1.0 # kN
println("設計せん断力				Qs=", qs, "kN")
println("")

println("ボルト接合部（2-M12、F4T）の検討")
qb = 7.79 * 1.5 # kN
println("ボルト1本あたり短期許容せん断力	qb=", qb, "kN")
n = 2
println("ボルト本数				n=", n)
qa1 = n * qb # kN
println("ボルト接合部許容せん断力		Qa1=n・qb=", qa1, "kN", qa1 > qs ? ">" : "<", "Qs→", qa1 > qs ? "OK" : "NG")
println("")

println("ガセットプレート部（PL-6、SS400）の検討")
println("ガセットプレート幅を胴縁と同じとして100mmとする。")
h = 100
t = 6.0
d = 14
ae2 = t * h - t * d
println("ガセットプレート有効断面積		Ae2=", t, "mm×", h, "mm-", t, "mm×", d, "mm=", ae2, "mm2")
fs2 = 136 # N/mm2
println("ガセットプレート短期許容せん断応力度	fs2=", fs2, "N/mm2")
qa2 = fs2 * ae2 / 1000
println("ガセットプレート許容せん断力		Qa2=fs2・Ae2=", qa2, "kN", qa2 > qs ? ">" : "<", "Qs→", qa2 > qs ? "OK" : "NG")
println("")

