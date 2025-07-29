# OpenTSEA
Open Tsunami Structural Engineering Analysis tools
[The OpenTSEA-toolkit is still under development but is fully functional]

The OpenTSEA-toolkit provides a framework and functional tool for the fragility assessment of structures against user-specified tsunami loading scenarios. The OpenTSEA-toolkit brings together the computation of structure and tsunami dependent forces and facilitates tsunami structural response analysis. The toolkit employs a systematic approach for modelling and assessing structures' tsunami response under a multitude of scenarios, using OpenSees (McKenna, F. (1997)) via the Variable Depth Push Over (VDPO) analysis method. The toolkit enables users to accurately simulate the structural arrangement and building envelope all the while considering different permeability phases — enabling flow through the building at distinct stages. Lateral hydrodynamic tsunami forces can be calculated using either the ASCE 7/22 or the Foster et al 2017 formulations. 

*OpenTSEA is currently configured for reinforced concrete structures.

## License
This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Citation
If you use the OpenTSEA toolkit in your research, please cite:
Jonas Cels, 2025. OpenTSEA. Zenodo. https://doi.org/[YOUR-DOI]

## Getting Started

### Prerequisites
- MATLAB with required toolboxes:
1. Symbolic Math Toolbox

### Installation
1. Clone or download this repository
2. Add the toolkit folder to your MATLAB path

### Quick Start
1. Open and run the main control file: `Tsunami_Fragility_Analysis.mlx`
2. The toolkit is pre-configured to run on the example structure located in the `EXAMPLE` folder

### Example Files
The `EXAMPLE` folder contains the following files to help you get started:

- **`LIST_FEM_scenarios.xlsx`** - Links structural models to their corresponding tsunami scenarios
- **`Y_tsunamiScenarios.xlsx`** - Control file for defining tsunami VDPO (Variable Depth Push Over) scenario parameters, it is set to use the Foster et al 2017 formulations and is set to run in the Y direction
- **`Y_3z_9x_2y_GF0Q_F1Q_I2Q_B2Q.xlsx`** - Sample structural model of a three-story school building from Sri Lanka

### Usage
1. Start with the provided example to understand the workflow
2. Modify the tsunami scenarios in `Y_tsunamiScenarios.xlsx` for your analysis
3. Replace the example structure file with your own structural model following the same Excel format
4. Update `LIST_FEM_scenarios.xlsx` to link your structure to the desired scenarios
5. Run the analysis through `Tsunami_Fragility_Analysis.mlx`, amend the controls in each section of the process accordingly (I recommend you run one section at a time).
