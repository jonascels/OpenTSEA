# Gravity-analysis parameters
puts "Building model applying vertical loads ..."

set Tol 1.0e-8;							# convergence tolerance for test

constraints Transformation;   			# how it handles boundary conditions
numberer RCM;							# renumber dof's to minimize band-width (optimization), if you want to
system BandGeneral;						# how to store and solve the system of equations in the analysis (large model: try UmfPack)
test EnergyIncr $Tol 20; 				# determine if convergence has been achieved at the end of an iteration step
algorithm Newton;						# use Newton's solution algorithm: updates tangent stiffness at every iteration
set NstepGravity 10;  					# apply gravity in 10 steps
set DGravity [expr 1./$NstepGravity]; 	# first load increment;
integrator LoadControl $DGravity;		# determine the next time step for an analysis
analysis Static;						# define type of analysis static or transient
analyze $NstepGravity;					# apply gravity

loadConst -time 0.0; 					# maintain constant gravity loads and reset time to zero
wipeAnalysis; 							#  destroy all components of the Analysis object, i.e. any objects created with system, numberer, constraints, integrator, algorithm, and analysis commands
puts "Structural model built and gravity analysis complete - gravity loads held constant"



