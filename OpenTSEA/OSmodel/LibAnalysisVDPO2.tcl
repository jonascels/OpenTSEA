# VDPO2 Response Control Phase Static Pushover Analysis.
puts "VDPO2 - Response Control Phase"

set fmt1 "%s control node %d, dof %.1i, Displacement = %.4f %s"
puts [format $fmt1 "Response control start:" $IDctrlNode $IDctrlDOF [nodeDisp $IDctrlNode $IDctrlDOF] $LunitTXT]

set fmt2 "Holding load pattern constant at time step: %.4f"
puts [format $fmt2 [getTime]]

loadConst -time 0.0
wipeAnalysis

# Solver, Constraints, Numberer
system UmfPack
constraints Transformation
numberer RCM

# Convergence test setup
set TolStatic 1.e-6
set maxNumIterStatic 100
set printFlagStatic 0
set testTypeStatic EnergyIncr
test $testTypeStatic $TolStatic $maxNumIterStatic $printFlagStatic

# Analysis algorithm and integrator setup
set algorithmTypeStatic Newton
algorithm $algorithmTypeStatic
integrator DisplacementControl $IDctrlNode $IDctrlDOF $Dincr
analysis Static

# Analyze
set Nsteps [expr int($Dmax/$Dincr)]
set ok [analyze $Nsteps]

# Loop to try and continue pushover by adjusting analysis settings
if {$ok != 0} {
    set Dstep 0.0
    set ok 0
    while {$Dstep <= 1.0 && $ok == 0} {
        set controlDisp [nodeDisp $IDctrlNode $IDctrlDOF]
        set Dstep [expr $controlDisp/$Dmax]
        set ok [analyze 1]
        
        if {$ok != 0} {
            set Nk 4
            set DincrReduced [expr $Dincr/$Nk]
            integrator DisplacementControl  $IDctrlNode $IDctrlDOF $DincrReduced
            
            for {set ik 1} {$ik <= $Nk} {incr ik 1} {
                puts "$ik"
                set currentCtrlNodeDisp [nodeDisp $IDctrlNode $IDctrlDOF]
                puts "Current control node displacement is $currentCtrlNodeDisp"
                set printFlagConvergeStatic 0
                set ok [analyze 1]
                
                if {$ok != 0} {
                    puts "Trying Newton with Initial Tangent ..."
                    test NormDispIncr $TolStatic $maxNumIterStatic $printFlagConvergeStatic
                    algorithm Newton -initial
                    set ok [analyze 1]
                    test $testTypeStatic $TolStatic $maxNumIterStatic $printFlagStatic
                    algorithm $algorithmTypeStatic
                }
                
                if {$ok != 0} {
                    puts "Trying Broyden ..."
                    algorithm Broyden 8
                    set ok [analyze 1]
                    algorithm $algorithmTypeStatic
                }

                if {$ok != 0} {
                    puts "Trying NewtonWithLineSearch ..."
                    algorithm NewtonLineSearch 0.8
                    set ok [analyze 1]
                    algorithm $algorithmTypeStatic
                }

                if {$ok != 0} {
                    puts [format $fmt1 "Analysis stopped:" $IDctrlNode $IDctrlDOF [nodeDisp $IDctrlNode $IDctrlDOF] $LunitTXT]
                    break
                }
            }
            integrator DisplacementControl $IDctrlNode $IDctrlDOF $Dincr
        }
    }
}

if {$ok != 0} {
    puts [format $fmt1 "Analysis stopped:" $IDctrlNode $IDctrlDOF [nodeDisp $IDctrlNode $IDctrlDOF] $LunitTXT]
} else {
    puts "Response control analysis completed, displacement target has been reached."
    puts [format $fmt1 "Response control end:" $IDctrlNode $IDctrlDOF [nodeDisp $IDctrlNode $IDctrlDOF] $LunitTXT]
}

wipe
