# VDPO Load Control Phase Static Pushover Analysis.
puts "VDPO - Load Control Phase"

source LoadControlTimeSteps.tcl

# Solver, Constraints, Numberer
system UmfPack 
constraints Transformation
numberer RCM

# Convergence test setup
set TolStatic 1.e-6
set maxNumIter 100
set printFlagStatic 0
set testTypeStatic NormDispIncr
test $testTypeStatic $TolStatic $maxNumIter $printFlagStatic

# Analysis algorithm and integrator setup
set algorithmTypeStatic Newton
algorithm $algorithmTypeStatic
integrator LoadControl $incr
analysis Static

# Analyze
set ok [analyze $Nsteps]

# # Loop to try and continue pushover by adjusting analysis settings
# if {$ok != 0} {
# 	while {1} {
# 		set ok [analyze 1]

# 		# Adjust tolerance if not converging
# 		puts "Reducing tolerance to 1.e-5 ..."
# 		test $testTypeStatic 1.e-5 $maxNumIter $printFlagStatic
# 		set ok [analyze 1]

# 		if {$ok == 0} {
# 			break
# 		}

# 		puts "Analysis stopped. End time: [getTime]"
# 		break
# 	}
# }

if {$ok != 0} {
    puts "Analysis stopped, target tsunami inundation has not been reached. End time: [getTime]"
} else {
    puts "Load control phase complete, target tsunami inundation has been reached. End time: [getTime]"
}