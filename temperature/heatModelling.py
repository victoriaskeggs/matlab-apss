import numpy as np
from scipy.interpolate import UnivariateSpline
import matplotlib.pyplot as plt
import matplotlib.animation as animation

# constants
conductivity = 5.67*10**-8  # W/m**2.K**4, Stefan-Boltzmann constant
Hsun = 64*10**6  # W/m**2, power density at the sun's surface
Rearth = 150*10**9  # m, distance of earth from sun's center
Rsun = 695*10**6  # m, radius of sun
Tspace = 0  # T, temperature of space

# dependent on material
density = 2700  # kg/m**3, density
heat_capacity = 0.902*1000  # J/kgC, heat capacity of material
resistivity = 2.65*10**-8  # Ohm.m, resistivity in wire
emissivity = 1  # emissitivity of material

# dependent on tether
length = 500  # m, length of tether

# dependent on orbit
period = 7200  # s, orbital period


def perimeter(xs):
    """Returns array of tether perimeters as a function of tether positions"""
    return np.zeros(len(xs)) + 0.00314  # m


def current(xs, t):
    """Returns array of tether currents as a function of tether positions and time"""
    return np.linspace(0, 30e-3, len(xs))
    # return np.zeros(len(xs)) + 30*10**-3  # A


def cross_sect_area(xs):
    """Returns array of tether cross sectional areas as a function of tether positions"""
    return np.zeros(len(xs)) + 7.85e-7  # m2


def sun_power_density(t):
    """Returns array of sun power densities as a function of time"""
    if np.floor(t * 2 / period) % 2 == 1:
        return 0
    else:
        return Hsun * Rsun**2/Rearth**2  # W/m**2


def calc_derivative(ys, xs, derivative):
    """Takes in an array of ys and xs (y=f(x)) and calculates array of dny/dxn where n is specified."""
    y_spl_derivative = UnivariateSpline(xs, ys, s=0, k=4).derivative(n=derivative)
    return y_spl_derivative(xs)


def heat_equation(Ts, xs):
    """Change in temp as given in the heat equation"""
    return conductivity/heat_capacity/density*calc_derivative(Ts, xs, 2)


def black_body_radiation(Ts, xs):
    """Change in temp due to blackbody radiation"""
    return 2*emissivity*conductivity*(Ts**4-Tspace**4)*perimeter(xs)/heat_capacity/density/cross_sect_area(xs)


def current_heating(xs, t):
    """Change in temp due to ohmic heating"""
    return current(xs, t)**2*resistivity/cross_sect_area(xs)**2/heat_capacity/density


def sun_heating(xs, t):
    """Change in temp due to sun heating"""
    return sun_power_density(t)*perimeter(xs)/2/heat_capacity/density/cross_sect_area(xs)


# simulation settings
num_nodes = 10  # number of nodes to simulate
num_timesteps = 2000
real_time_to_simulate = period*2
timestep_size = real_time_to_simulate / num_timesteps
t0 = 0  # s, initial time
T0 = 200  # K, initial temperature

positions = np.linspace(0, length, num_nodes)  # position of each node
temperatures = np.zeros(num_nodes) + T0  # stores current temp
history_of_temperatures = [np.copy(temperatures)]  # store all calculated tether temp profiles


for timestep in range(num_timesteps):
    t = t0 + timestep*timestep_size
    dt_heat = heat_equation(temperatures, positions)
    dt_blackbody = black_body_radiation(temperatures, positions)
    dt_current = current_heating(positions, t)
    dt_sun = sun_heating(positions, t)
    temperatures += timestep_size*(dt_heat-dt_blackbody+dt_current+dt_sun)  # update current temp
    history_of_temperatures.append(np.copy(temperatures))  # save current temp profile


def animate_history(i):
    temps.set_data([positions, history_of_temperatures[i]])
    timetext.set_text(f'{i*timestep_size/period:<6.4f} orbital periods')
    return temps, timetext,


fig = plt.figure(figsize=(6, 8))
ax = fig.add_subplot(111)

ax.set_title("Temperature vs Position")
ax.set_xlim(0, length)
ax.set_ylim(0, 400)
ax.set_xlabel("Tether position (m)")
ax.set_ylabel("Tether temperature (K)")
temps, = ax.plot([], [], '-')
timetext = ax.text(length / 8, 10, "0")

animation_object = animation.FuncAnimation(fig, animate_history,
                                                frames=num_timesteps,
                                                save_count=num_timesteps,
                                                interval=1, blit=True)
plt.show()
