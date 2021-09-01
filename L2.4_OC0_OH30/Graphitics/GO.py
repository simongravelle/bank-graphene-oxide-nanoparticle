import makegraphitics as mg
import sys

f = sys.argv[1];
g = sys.argv[2];

forcefield = "OPLS"

# the center of H at a distance of about 6 angstroms

motif = mg.molecules.Rectangle_Graphene(24,24)
flake = mg.Crystal(motif, [1, 1, 1])

#oxidiser = mg.reactors.Oxidiser(ratio=2.5, video_xyz=20,
                                #new_island_freq=1e14, method='rf')

oxidiser = mg.reactors.Oxidiser(
# carbon over oxygen ratio
# if ratio large, no group at the surface
# 13 will lead to 0-5 groups for the 22-20 surface. decrese for more group

ratio=int(f),

video_xyz=100, 

# the larger the better repartition
new_island_freq=1e10, 

method='rf',

# if edge_OHratio=1, only OH at the edge
# if edge_OHratio=0, only H at the edge
edge_OHratio = float(g),


# if surface_OHratio=1, only OH at the surface
# if surface_OHratio=0, only O at the surface
surface_OHratio = 1,

# if edge_carboxyl_ratio=0, only one group per carbon atom at the edge
# if edge_carboxyl_ratio=0.75, about two groups per carbon atom at the edge (definition of a carboxyl)
edge_carboxyl_ratio = 0.0

)


flake = oxidiser.react(flake)

mg.Parameterise(flake, flake.vdw_defs)

name = 'GO'
output = mg.Writer(flake, name)
output.write_xyz(name+'.xyz')
output.write_lammps(name+'.data')
#output.write_reaxff(name+'reax.data')
