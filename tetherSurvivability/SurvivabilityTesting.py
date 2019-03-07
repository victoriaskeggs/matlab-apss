import numpy as np
import matplotlib.pyplot as plt
from uncertainties import unumpy
from uncertainties import ufloat
# ----------------------------------------------------------------------------------------------------------------------

# taking input parameters

m_data = "KesslerTetherinertial_d.dia"  # MASTER output file
s_data = "KesslerTetherinertial_d.dia.sigm" # Uncertanities

l_step_size = 1          # we iterate over tether length
l_min = 1
l_max = 2000
l_test_range = np.arange(l_min, l_max + l_step_size, l_step_size)

d_step_size = 0.001e-3          # we iterate over tether length
d_min = 0.01e-3
d_max = 2e-3
d_test_range = np.arange(d_min, d_max + d_step_size, d_step_size)



kc = 0.3                  # lethality coeefiecient -  the ratio of minimum lethal impactor diameter to radius
dt = 0.7                     # critical distance - ignores glancing blows
t = 2                      # simulated time, in months
t_y = t / 12               # simulated time, in years
alt = "400km"             # altitude of sat - only used for plotting, input to MASTER
# ----------------------------------------------------------------------------------------------------------------------

# defining functions


def a_eff(w, d, l , crit=dt):

    """
        effective area function - w for width of body, l for length, t for critical distance,
        and d for impactor diameter.
        This function accounts for macroscopic size of impactors and discounts glancing blows
    """

    a = l * ((crit * w) + d)
    return a


# ----------------------------------------------------------------------------------------------------------------------

# initialising data arrays

# input data arrays
diam = np.array([])  # impactor diameters, in m
flux = np.array([])  # differential impactor flux at this diameter, in impactors per square meter per year
sigma = np.array([])

# generated data arrays - used for plotting
cum_flux = np.array([])
rate_impacts_data = np.array([])
# ----------------------------------------------------------------------------------------------------------------------

# processing data input

for line in open(m_data):       # taking MASTER input
    li = line.strip()           # removing redundant white space
    if not li.startswith("#"):  # ignoring commented lines - simulation information

        li_array = np.array([float(x) for x in li.split()])  # takes data  for each particle size

        # taking relevant data
        diam = np.append(diam, li_array[0])
        flux = np.append(flux, li_array[-1])


for line in open(s_data):
    li = line.strip()
    if not li.startswith("#"):

        li_array = np.array([float(x) for x in li.split()])
        sigma = np.append(sigma, li_array[-1])

# ----------------------------------------------------------------------------------------------------------------------=

# initialising testing
# Loop over tether length, radius
# write csv file of survivability
prob = np.zeros((len(d_test_range) + 1, len(l_test_range) + 1))
prob[0, 1:] = l_test_range
prob[1:, 0] = d_test_range

for i, r in enumerate(d_test_range):  # testing radii of tether
    for j, l in enumerate(l_test_range):
        mask = diam > (kc * r)                         # defining a mask to only care about lethal impactors
        diam_lethal = diam[mask]
        flux_lethal = flux[mask]

        areas = a_eff(r, diam_lethal, l)

        diff_rate_impacts = areas * flux_lethal        # the differential rate of impacts, particles per year per meter

        rate_impacts = np.sum(diff_rate_impacts)  # impacts per year

        survival_probability = np.exp(-1 * rate_impacts * t_y)

        prob[i+1, j+1] = survival_probability

np.savetxt("probabilities.csv", prob, delimiter=",")
