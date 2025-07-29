# --------------------------------------------------------------------------------------------------
# LibUnits.tcl -- define system of units
#		Silvia Mazzoni & Frank McKenna, 2006
#

# define UNITS ----------------------------------------------------------------------------
set m 1.0;				# define basic units -- output units
set kN 1.0; 			# define basic units -- output units
set sec 1.0;  			# define basic units -- output units

set LunitTXT "m";			# define basic-unit text for output
set FunitTXT "kN";			# define basic-unit text for output
set TunitTXT "sec";			# define basic-unit text for output

set cm [expr 0.01*$m]; 		# define engineering units
set mm [expr $m/1000];
set m2 [expr pow($m,2)]; 		# define engineering units
set cm2 [expr pow($cm,2)]; 		# define engineering units
set mm2 [expr pow($mm,2)];
set m4 [expr pow($m,4)]; 		# define engineering units
set m3 [expr pow($m,3)]; 		# define engineering units
set cm4 [expr pow($cm,4)]; 		# define engineering units
set mm4 [expr pow($mm,4)]; 		# define engineering units
set N [expr $kN/1000.];
set MPa [expr $N/$mm2];		# pounds force
set kPa [expr $kN/pow($m,2)];		# pounds per cubic foot
set PI 3.14; 		# define constants
set g [expr 9.806*$m/pow($sec,2)]; 	# gravitational acceleration
set Ubig 1.e10; 			# a really large number
set Usmall 1.e-4; 		# a really small number

