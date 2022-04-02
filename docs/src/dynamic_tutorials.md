```@index
Modules = [GeneDrive]
Pages   = ["dynamic_tutorials.md"]
```
# Dynamic Model

The following examples demonstrate how to create and run Ordinary Differential Equation (ODE) problems in `GeneDrive.jl`. Dynamic models allow us to understand the behavior of the system of interest; below, we see the effect of environmental and then anthropogenic perturbations. 

## Environmental Dynamics 

First, we will characterize the impact of seasonal temperature fluctuations on our study population. This experiment uses the information from the `node2` data model created in the previous example.

```@example 
# Define the time horizon 
tspan = (1,365)

# Select solver (see DifferentialEquations.jl for options)
solver = OrdinaryDiffEq.Tsit5()

# Solve 
sol = solve_population_model(node2, [temperature], solver, tspan);

# Format results
results = sol_to_dict(node1, sol)

# Visualize 
plot(results)
```

## Intervention Dynamics 

Here we model the dynamics of public health interventions that release genetically modified mosquitoes to replace or suppress wildtypes (mitigating the risk of disease spread). This experiment also accounts for the environmental dynamics we saw above. Importantly, the timing, size, sex, and genotype used for interventions varies according to the genetic tool. 

The code below demonstrates how to set up the RIDL (Release of Insects with Dominant Lethal) intervention, therefore only male organisms that are homozygous for the modification are released.
```@example 
# Use new genetics
genetics = genetics_ridl();

# Re-use other organismal data for brevity 
organisms = make_organisms(species, genetics, enviro_response);

# Define a new location
coordinates3 = (16.9203, 145.7710)
node3 = Node(:Cairns, organisms, temperature, coordinates3);

# Define the size and timing of releases 
release_size = 100;
release_times = [4.0, 11.0, 18.0, 25.0, 32.0, 39.0, 
    46.0, 53.0, 60.0, 67.0];

# The genotype to be released (apply helper function)
release_genotype = get_homozygous_modified(node3, species)

# Specify the sex of releases and create the `Release` object
releases_males = Release(node3, species, Male, release_genotype, 
    release_times, release_size);
```

With the new problem now set up, we solve it and analyze the results: 
```@example 
# Solve (re-use temperature, solver, and tspan from previous example)
sol = solve_population_model(node3, [temperature], [releases_males], 
    solver, tspan);

# Format
results = sol_to_dict(node3, sol)

# Visualize 
plot(results)
```