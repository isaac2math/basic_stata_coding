*two tail bootstrap test

program define bstest_two

	*set trace on 
	
    matrix result_mean = e(b)
	scalar mean_corr   = result_mean[1,1]
	matrix result_se   = e(se)
	scalar se_corr     = result_se[1,1]

	scalar hyp_value = `1'
	scalar sig_level = `2'
	scalar bs_test   = (mean_corr - hyp_value) / se_corr
	scalar p_two     = 2 * normal(-1 * abs(bs_test))
	
	display
	display "Table 1: two-tail bootstrap test result"
	display "---------------------------------------"
	display "the bs test statistic is " bs_test
	display "the two-tail p-vaplue is " p_two
	display "---------------------------------------"

	if p_two < sig_level{
		display "H0 is rejected since p value is less than sig level =" sig_level
	}
	else if p_two >= sig_level{
		display "H0 is not rejected since p value is larger than sig level =" sig_level
	}
	
	if abs(bs_test) > 6 {
		scalar bs_test = 5.9
	} 
	
	local low_bd = invnormal(sig_level/2)
	local upp_bd = -1 * invnormal(sig_level/2)
	local test_l = bs_test
	
	twoway (function y = normalden(x), range(-6 `low_bd') recast(area) color(blue)) (function y = normalden(x), range(`low_bd' `upp_bd' ) recast(area) color(gray)) (function y = normalden(x), range( `upp_bd' 6) recast(area) color(green)) (scatteri -0.05 `test_l' 0.5 `test_l', recast(line) lwidth(medium) lc(red)), legend(label(1 "Left-tail rejection region") label(2 "Non-rejection region") label(3 "Right-tail rejection region") label(4 "test statistic")) title("Graph 1: Two-tail bootstrap test")
    
    scalar drop mean_corr se_corr hyp_value sig_level bs_test p_two
	matrix drop result_mean result_se
	
end
